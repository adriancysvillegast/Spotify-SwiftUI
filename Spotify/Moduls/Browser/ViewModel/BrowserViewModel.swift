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
    
    // MARK: - Methods
    
    func getData() {
        APIManager.shared.getNewRelease { [weak self] response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    let data = result.albums.items.compactMap {
                        NewReleasesModelCell(idAlbum: $0.id,
                                             nameAlbum: $0.name,
                                             nameArtist: $0.artists.first?.name ?? "-",
                                             urlImage: URL(string: $0.images.first?.url ?? "-"))
                    }
                    self?.newReleasesCell = data
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    deinit {
        print("good")
    }
}
