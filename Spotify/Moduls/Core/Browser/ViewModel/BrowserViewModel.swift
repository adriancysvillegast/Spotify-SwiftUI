//
//  BrowserViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import Foundation
import SwiftUI



class BrowserViewModel: ObservableObject {
    // MARK: - Properties
    @Published var newReleasesCell: [ItemModelCell] = []
    @Published var featureListsCell: [ItemModelCell] = []
    @Published var rockListCell: [TrackModelCell] = []
    @Published var alternativeListCell: [TrackModelCell] = []
    @Published var houseListCell: [TrackModelCell] = []
    @Published var trackAdded: Bool = false
    @Published var errorAddingToPlaylist: Bool = false
    // MARK: - Methods
    
    func getData() {
        
        APIManager.shared.getNewRelease { [weak self] response in
            switch response {
            case .success(let result):
                
                let data = result.albums.items.compactMap {
                    ItemModelCell(id: $0.id,
                                  nameItem: $0.name,
                                  creatorName: $0.artists.first?.name ?? "-",
                                  image: URL(string: $0.images.first?.url ?? "-"),
                                  description: "",
                                  isPlaylist: false)

                }
                DispatchQueue.main.async {
                    self?.newReleasesCell = data
                }
            case .failure(let error):
                print(error)
            }
        }
        
        APIManager.shared.getFeaturePlaylist { [weak self] response in
            switch response {
            case .success(let success):
                let playlist = success.playlists.items.compactMap {
                    
                    ItemModelCell(id: $0.id,
                                  nameItem: $0.name,
                                  creatorName: $0.owner.displayName,
                                  image: URL(string: $0.images.first?.url ?? "-"),
                                  description: $0.description,
                                  isPlaylist: true)
                }
                DispatchQueue.main.async {
                    self?.featureListsCell = playlist
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
//        alternative
        APIManager.shared.getRecomendationWithAGenre(
            genre: Constants.alternative) { [weak self] result in
                switch result {
                case .success(let success):
//                    print("Alternative: \(success.tracks)")
                    let tracks = success.tracks.compactMap {
                        TrackModelCell(
                            image: URL(string: $0.album?.images.first?.url ?? "-"),
                            artists: $0.artists.first?.name ?? "-",
                            explicit: $0.explicit,
                            id: $0.id,
                            name: $0.name,
                            previewUrl: URL(string: $0.previewUrl ?? "-"))
                    }
                    DispatchQueue.main.async {
                        self?.alternativeListCell = tracks
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
        }
        
//        hard-rock
        APIManager.shared.getRecomendationWithAGenre(
            genre: Constants.hardRock) { [weak self] result in
                switch result {
                case .success(let success):
//                    print("hard-rock: \(success.tracks)")
                    let tracks = success.tracks.compactMap {
                        TrackModelCell(
                            image: URL(string: $0.album?.images.first?.url ?? "-"),
                            artists: $0.artists.first?.name ?? "-",
                            explicit: $0.explicit,
                            id: $0.id,
                            name: $0.name,
                            previewUrl: URL(string: $0.previewUrl ?? "-"))
                    }
                    DispatchQueue.main.async {
                        self?.rockListCell = tracks
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
        }
//        house
        
        APIManager.shared.getRecomendationWithAGenre(
            genre: Constants.house) { [weak self] result in
                switch result {
                case .success(let success):
//                    print("house: \(success.tracks)")
                    let tracks = success.tracks.compactMap {
                        TrackModelCell(
                            image: URL(string: $0.album?.images.first?.url ?? "-"),
                            artists: $0.artists.first?.name ?? "-",
                            explicit: $0.explicit,
                            id: $0.id,
                            name: $0.name,
                            previewUrl: URL(string: $0.previewUrl ?? "-"))
                    }
                    DispatchQueue.main.async {
                        self?.houseListCell = tracks
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
        }
        
    }
    
    // MARK: - Add To Favorite tracks
    func addToFavoriteTracks(trackId: String) {
        
//        print(trackId)
        APIManager.shared.saveFavoriteTracks(trackId: trackId) { [weak self] success in
            if success{
                DispatchQueue.main.async {
                    self?.trackAdded = success
                }
                
            }
        }
    }
    
    func saveItemOnPlaylist(item: String, idPlaylist: String ){
        APIManager.shared.addTrackToPlaylist(trackId: item,
                                             playlistId: idPlaylist) { success in
            
            if !success {
                DispatchQueue.main.async {
                    self.errorAddingToPlaylist.toggle()
                    
                }
            }
        }
    }
    
    
    deinit {
        print("gooooooood")
    }
}
