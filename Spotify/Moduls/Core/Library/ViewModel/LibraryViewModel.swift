//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 8/12/23.
//

import Foundation
import SwiftUI

class LibraryViewModel: ObservableObject {
    // MARK: - Poperties
    
    @AppStorage("updateLibrary") var updateLibrary: Bool?
    
    @Published var allTracks: [ItemModelCell] = []
    @Published var playlists: [ItemModelCell] = []
    @Published var albums: [ItemModelCell] = []
    @Published var errorCreatingPlaylist: Bool = false
    @Published var wasAdded: Bool = false
    // MARK: - Methods

    func getUserFavouriteTracks() {
//        show favorite tracks
        APIManager.shared.getFavoriteTracks { [weak self] result in
            switch result {
            case .success(let success):
                let tracks = success.items.compactMap {
                    ItemModelCell(id: $0.track.id,
                                  nameItem: $0.track.name,
                                  creatorName: $0.track.artists.first?.name ?? "-",
                                  image: URL(string: $0.track.album?.images.first?.url ?? "-"),
                                  description: "",
                                  isPlaylist: false)
                }
                DispatchQueue.main.async{
                    self?.allTracks = tracks
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func getPlaylists() {
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
                    self?.playlists = playlists
                }
            case .failure(let failure):
                print(failure.localizedDescription + "jjjj")
            }
        }
        
    }
    
    func getAlbums() {
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
                    self?.albums = albums
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    

    
    func createNewPlaylist(name: String) {
        APIManager.shared.createPlaylist(name: name) { success in
            //add a acction
            DispatchQueue.main.async {
                if !success {
                    self.errorCreatingPlaylist = true
                }else if success {
                    self.wasAdded = true
                }
            }
        }
    }
    
}
