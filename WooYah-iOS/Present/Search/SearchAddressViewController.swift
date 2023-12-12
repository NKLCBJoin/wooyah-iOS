//
//  SearchAddressViewController.swift
//  WooYah-iOS
//
//  Created by 최지철 on 2023/10/31.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift
import CoreLocation

class SearchAddressViewController: UIViewController {

    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    private let locate = PublishSubject<String>()
    private let coordinate = PublishSubject<[Double]>()
    
    var coordinateSubject: Observable<[Double]> {
        return coordinate.asObservable()
    }

    var locateSubject: Observable<String> {
        return locate.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .white
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView?.navigationDelegate = self

        guard let url = URL(string: "https://kasroid.github.io/Kakao-Postcode/"),
            let webView = webView
            else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
    }

    private func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false

        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
    }
    
    private func saveLocate(locate: String) {
        self.dismiss(animated: true,completion: { [weak self] in
            self?.locate.onNext(locate)
        })
    }
    
    func changeToCoordinate(address: String?){
        var latitude: Double?
        var longitude: Double?
        
        if let address = address {
            CLGeocoder().geocodeAddressString(address) { [weak self] (placemarks, error) in
                guard let self = self else { return }

                if let placemarks = placemarks, let location = placemarks.first?.location {
                    latitude = location.coordinate.latitude
                    longitude = location.coordinate.longitude
                    let coordinates = [latitude ?? 0.0, longitude ?? 0.0]
                    coordinate.onNext(coordinates)

                } else {
                    print("주소를 찾을 수 없습니다.")
                }
            }
        }
    }
}

extension SearchAddressViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            if let address = data["roadAddress"] as? String {
                self.saveLocate(locate: address)
                self.changeToCoordinate(address: address)
            }
        }

    }
}

extension SearchAddressViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
