//
//  AuthManager.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 19/11/23.
//

import Foundation
import SwiftUI



final class AuthManager: ObservableObject {

    // MARK: - Properties
    static let shared = AuthManager()
    
    @AppStorage("accessToken") var accessToken: String?
    @AppStorage("refreshToken") var refreshToken: String?
    
    @State var errorLogIn: Bool = false
    @State var errorLogInMessage: String?
    
    private var refreshingToken = false

    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expires_in") as? Date
    }
    
    private var shouldResfrestToken: Bool {
        guard let expirationDate = tokenExpirationDate else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Methods
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool)-> Void)) {
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURL)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clienteSecret
        let data = basicToken.data(using: .utf8)
        
        guard let basic64String = data?.base64EncodedString() else {
            print("error getting basic64")
            completion(false)
            return
        }
        request.setValue("Basic \(basic64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(AuthResponse.self, from: data)
                self.cacheToken(result: result)
//                print("SUCCESS: \(result)")
                completion(true)
            }catch {
                print(error.localizedDescription)
                self.errorLogIn = true
                self.errorLogInMessage = error.localizedDescription
                completion(false)
            }
        }
        task.resume()
    }
    
    // Supplies valid token to be used with API Calls
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldResfrestToken {
            //refresh
            refreshIfNeeded { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        }else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshIfNeeded(completion: ((Bool)-> Void)?) {
        guard !refreshingToken else {
            return
        }
        
        guard shouldResfrestToken else {
            completion?(true)
            return
        }
        
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        //refresh request
        
        guard let url = URL(string: Constants.tokenAPIURL) else { return }
        
        refreshingToken = true
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clienteSecret
        let data = basicToken.data(using: .utf8)
        
        guard let basic64String = data?.base64EncodedString() else {
            print("error getting basic64")
            completion?(false)
            return
        }
        request.setValue("Basic \(basic64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            self.refreshingToken = false
            guard let data = data, error == nil else {
                completion?(false)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(AuthResponse.self, from: data)
//                print(result.accessToken)
                self.onRefreshBlocks.forEach { $0(result.accessToken) }
                self.onRefreshBlocks.removeAll()
                self.cacheToken(result: result)
                completion?(true)
            }catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
        task.resume()
        
    }
    
    private func cacheToken(result: AuthResponse) {
        DispatchQueue.main.async {
            self.accessToken = result.accessToken
            
            UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expires_in")
            if let refresh = result.refreshToken{
                self.refreshToken = refresh
            }
        }
        
       
        
    }
    
    public func signOut(completion: (Bool) -> Void ) {
        UserDefaults.standard.set(nil, forKey: "access_token")
        UserDefaults.standard.set(nil, forKey: "expires_in")
        UserDefaults.standard.set(nil, forKey: "refresh_token")
        completion(true)
    }
    
}
