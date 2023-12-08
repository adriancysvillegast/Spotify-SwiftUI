//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 8/12/23.
//

import Foundation

class LibraryViewModel: ObservableObject {
    // MARK: - Poperties
    @Published var playlists: [ItemModelCell] = []
    
    // MARK: - Methods
    
    func getPlaylist() {
        APIManager.shared.getCurrentUserPlaylists { [weak self] result in
            switch result {
            case .success(let success):
                
                let playlists = success.compactMap {
                    ItemModelCell(id: $0.id,
                                  nameItem: $0.name,
                                  creatorName: $0.owner.displayName,
                                  image: URL(string: $0.images.first?.url ?? "-"),
                                  description: $0.description
                    )
                }
                DispatchQueue.main.async {
                    self?.playlists = playlists
                }
            case .failure(let failure):
                print(failure.localizedDescription + "jjjj")
            }
        }
    }
}
