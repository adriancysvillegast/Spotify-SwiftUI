//
//  AuthValidation.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import SwiftUI


struct AuthView: UIViewControllerRepresentable {
        
    // MARK: - Properties

    typealias UIViewControllerType = AuthViewController
    private let url : URL? = Constants.signInURL
    
    
    
    private lazy var authManager: AuthManager = {
        let authManager = AuthManager.shared
        return authManager
    }()
    
    // MARK: - Methods
    func makeUIViewController(context: Context) -> AuthViewController {
        return AuthViewController()
    }
    
    
    func updateUIViewController(_ uiViewController: AuthViewController, context: Context) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        uiViewController.webView.load(request)
    }
    
    public mutating func getCode(code: String) {
        authManager.exchangeCodeForToken(code: code) { success in
            
        }
    }

}
