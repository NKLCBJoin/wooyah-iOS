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
import CoreLocation
import MapKit

struct LoginInfo {
    var method: String?
    var name: String?
    var phone: String?
    var id: String?
}

final class LoginViewModel: NSObject, ViewModelType {
    
    var disposeBag = DisposeBag()
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let kakaoLoginCompleteSubject = PublishSubject<Void>()
    var usecase: LoginUseCase
    private let locationManager = CLLocationManager.init()
    private let userinfo = UserInfo.self
    
    struct Input {

    }
    
    struct Output {

    }
    
    init(_ usercase: LoginUseCase) {
        self.usecase = usercase
        super.init()
        naverLoginInstance?.delegate = self
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.getLocation()
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
                //do something
                let userName = user.kakaoAccount?.profile?.nickname
                let userEmail = user.kakaoAccount?.email
                let userBirthday = user.kakaoAccount?.birthday
                let request = (LoginUserRequest(email: userEmail, nickname: userName, location: "양호동", phone: "010-2978-0086", device_number: ""))
                self.userinfo.shared.name = userName
                self.usecase.requestLogin(user: request)
                    .subscribe(onSuccess: { response in
                        print("Login success: \(response)")
                    }, onFailure: { error in
                        print("Login error: \(error)")
                    })
                    .disposed(by: self.disposeBag)
                self.kakaoLoginCompleteSubject.onNext(())
                
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

            self.userinfo.shared.name = name
            self.userinfo.shared.phone = phone

        }
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
extension LoginViewModel: ASAuthorizationControllerDelegate, NaverThirdPartyLoginConnectionDelegate, CLLocationManagerDelegate {
    func getLocation() {
        let geocoder = CLGeocoder.init()
        let location = self.locationManager.location
               
               if location != nil {
                   geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
                       if error != nil {
                           return
                       }
                       if let placemark = placemarks?.first {
                           var address = ""
                           if let locality = placemark.locality {
                               address = "\(address)\(locality) "
                               print(locality)
                           }
                           
                           if let thoroughfare = placemark.thoroughfare {
                               address = "\(address)\(thoroughfare) "
                               self.userinfo.shared.address = address
                               print(thoroughfare)
                           }
                           
                           if let subThoroughfare = placemark.subThoroughfare {
                               address = "\(address) \(subThoroughfare)"
                               print(subThoroughfare)
                    }
                }
            }
        }
    }
    
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


