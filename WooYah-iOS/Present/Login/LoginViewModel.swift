//
//  LoginViewModel.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/09/13.
//

import Foundation
import RxSwift
import KakaoSDKUser
import RxKakaoSDKUser
import RxKakaoSDKAuth
import KakaoSDKAuth
import RxCocoa
import NaverThirdPartyLogin
import AuthenticationServices
import Alamofire

struct LoginInfo {
    var method: String?
    var name: String?
    var phone: String?
    var id: String?
}

class LoginViewModel: NSObject, ViewModelType {
    
    var disposeBag = DisposeBag()
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    struct Input {
        
    }
    
    struct Output {
        
    }
    
    override init() {
        super.init()
        naverLoginInstance?.delegate = self
    }
    
     func signInWithKakao() {
        UserApi.shared.logout() { _ in }
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { [weak self] _ in
                    self?.getKakaUserInfo()
                },
                onError: { error in
                    print("카카오앱에러: \(error)")
                })
            .disposed(by: disposeBag)
        } else {
            UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext: { [weak self] _ in
                    self?.getKakaUserInfo()

                },
                onError: {  error in
                    print("카카오로그인 웹뷰에러: \(error)")
                })
            .disposed(by: disposeBag)
        }
    }
    
    private func getKakaUserInfo() {
        UserApi.shared.rx.me()
            .subscribe (onSuccess:{ user in
                print("me() success.")

                //do something
                let userName = user.kakaoAccount?.profile?.nickname
                let userEmail = user.kakaoAccount?.email
                let userBirthday = user.kakaoAccount?.birthday

                let contentText =
                "user name : \(userName)\n userEmail : \(userEmail) \nuserBirthday : \(userBirthday)"

                print("user - \(contentText)")

            }, onFailure: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func signInWithApple() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    func signInWithNaver() {
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }

        if !isValidAccessToken {
            return
        }

        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        guard let refreshToken = naverLoginInstance?.refreshToken else { return }

        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!

        let authorization = "\(tokenType) \(accessToken)"

        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])

        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else {return}
            guard let phone = object["mobile"] as? String else {return}

            
            let contentText =
            "user name : \(name)\n userEmail : \(email)\n userid : \(id)\n tokenType : \(tokenType)\n accessToken : \(accessToken)\n refreshToken : \(refreshToken)\n phone : \(phone)"
            print(contentText)
        }
    }
    
    func transform(input: Input) -> Output {

        return Output()
    }
}
extension LoginViewModel: ASAuthorizationControllerDelegate, NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("네이버 로그인")
        signInWithNaver()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("네이버 토큰\(String(describing: naverLoginInstance?.accessToken))")
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("네이버 로그아웃")

    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("에러 = \(error.localizedDescription)")

    }
    
    // MARK: NaverLogin


    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let familyName = appleIDCredential.fullName?.familyName
            let givenName = appleIDCredential.fullName?.givenName
            let email = appleIDCredential.email
            let state = appleIDCredential.state

            print("User Identifier: \(userIdentifier)")
            print("Family Name: \(familyName ?? "N/A")")
            print("Given Name: \(givenName ?? "N/A")")
            print("Email: \(email ?? "N/A")")
            print("State: \(state ?? "N/A")")
        }
    }
      
      // 애플 로그인 실패
      func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
          print("Apple Sign In Error: \(error.localizedDescription)")
      }
}


