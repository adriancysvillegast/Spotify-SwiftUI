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
    @Published var featureListsCell: [FeaturePlaylistModelCell] = []
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
        
        APIManager.shared.getFeaturePlaylist { response in
            switch response {
            case .success(let success):
                let playlist = success.playlists.items.compactMap {
                    FeaturePlaylistModelCell(id: $0.id,
                                             namePlaylist: $0.name,
                                             playlistOwner: $0.owner.displayName,
                                             image: URL(string: $0.images.first?.url ?? "-")
                    )
                }
                DispatchQueue.main.async {
                    self.featureListsCell = playlist
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
