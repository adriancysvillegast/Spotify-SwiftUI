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
    @Published var newReleasesCell: [NewReleasesModelCell] = []
    @Published var featureListsCell: [PlaylistsModelCell] = []
    @Published var rockListCell: [TrackModelCell] = []
    @Published var alternativeListCell: [TrackModelCell] = []
    @Published var houseListCell: [TrackModelCell] = []
    // MARK: - Methods
    
    func getData() {
        
        APIManager.shared.getNewRelease { [weak self] response in
            switch response {
            case .success(let result):
                
                let data = result.albums.items.compactMap {
                    NewReleasesModelCell(idAlbum: $0.id,
                                         nameAlbum: $0.name,
                                         nameArtist: $0.artists.first?.name ?? "-",
                                         urlImage: URL(string: $0.images.first?.url ?? "-"))
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
                    PlaylistsModelCell(id: $0.id,
                                       namePlaylist: $0.name,
                                       playlistOwner: $0.owner.displayName,
                                       image: URL(string: $0.images.first?.url ?? "-"),
                                       description: ""
                    )
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
    
    deinit {
        print("good")
    }
}
