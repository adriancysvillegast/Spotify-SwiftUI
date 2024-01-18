//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 4/1/24.
//

import Foundation
import SwiftUI


class ProfileViewModel: ObservableObject {

    // MARK: - Properties
    @Published var user: UserModelCell?
    @Published var isloaded: Bool = false
    @Published var errorLoading: Bool = false
    
    
    // MARK: - Methods
    
    func getUserInfo() {
        APIManager.shared.getUserProfile { [weak self] result in
            switch result {
            case .success(let data):
                let user =  UserModelCell(
                    name: data.displayName,
                    image: URL(string: data.images.first?.url ?? "-"),
                    country: data.country,
                    email: data.email
                )
                DispatchQueue.main.async {
                    self?.user = user
                    self?.isloaded.toggle()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                DispatchQueue.main.async {
                    self?.errorLoading.toggle()
                }
            }
        }
    }
    
    deinit {
        print("ProfileViewModel without memory leak")
    }
}
