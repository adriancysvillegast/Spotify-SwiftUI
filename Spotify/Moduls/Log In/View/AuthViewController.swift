//
//  AuthViewController.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {

       // MARK: - Properties
    
    var authView = AuthView()
       
       var webView: WKWebView = {
           let prefers = WKWebpagePreferences()
           prefers.allowsContentJavaScript = true
           let config = WKWebViewConfiguration()
           config.defaultWebpagePreferences = prefers
           let webView = WKWebView(frame: .zero,
                                   configuration: config)
           return webView
       }()
       
       public var compleationHandler: ((Bool) -> Void)?
    
       // MARK: - LifeCycle
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           setupView()
       }
       
       override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           self.webView.frame = view.bounds
       }
       
       
       // MARK: - setupView
       
       private func setupView() {
           title = "Sign In"
           view.backgroundColor = .systemBackground
           webView.navigationDelegate = self
           view.addSubview(webView)
           
       }
       
       // MARK: - Methods
       
       func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
           //to get the token after be accepted the permission from a user to access their playlists
           guard let url = webView.url else { return }
           let components = URLComponents(string: url.absoluteString)
   //        print(components)
           guard let code = components?.queryItems?.first(where: {$0.name == "code"})?.value else {
               return
           }
   //        webView.isHidden = true
           authView.getCode(code: code)
           dismiss(animated: true)
       }
       


}
