//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 8/12/23.
//

import Foundation

class LibraryViewModel: ObservableObject {
    // MARK: - Poperties
    @Published var allTracks: [ItemModelCell] = []
    @Published var playlists: [ItemModelCell] = []
    @Published var albums: [ItemModelCell] = []
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
                                  description: $0.description,
                                  isPlaylist: true
                    )
                }
                
                DispatchQueue.main.async {
                    self?.allTracks.append(contentsOf: playlists)
                    self?.playlists = playlists
                }
            case .failure(let failure):
                print(failure.localizedDescription + "jjjj")
            }
        }
        
        
        APIManager.shared.getCurrentUserAlbums { [weak self] result in
            switch result {
            case .success(let success):
                let albums = success.compactMap {
                    ItemModelCell(id: $0.id,
                                  nameItem: $0.name,
                                  creatorName: $0.artists.first?.name ?? "-",
                                  image: URL(string: $0.images.first?.url ?? "-"),
                                  description: "",
                                  isPlaylist: false
                    )
                }
                
                DispatchQueue.main.async {
                    self?.allTracks.append(contentsOf: albums)
                    self?.albums = albums
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
