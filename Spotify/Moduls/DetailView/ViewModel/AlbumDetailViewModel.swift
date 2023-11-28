//
//  AlbumDetailViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/11/23.
//

import Foundation
import SwiftUI

class AlbumDetailViewModel: ObservableObject {
    // MARK: - Properties
    @Published var albumDetailCell: AlbumDetailModelCell?
    @Published var tracks: [TrackModelCell] = []
    @State var showError: Bool = false

    // MARK: - Methods
    
    func getDetail(album: NewReleasesModelCell) {
        
        APIManager.shared.getDetail(
            album: album
        ) { result in
            
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    let data = AlbumDetailModelCell(
                        id: value.id,
                        image: URL(string: value.images.first?.url ?? "-"),
                        nameAlbum: value.name,
                        nameArtist: value.artists.first?.name ?? "--",
                        tracks: value.tracks.items)
                    
                    self.tracks = self.getArtist(audios: value.tracks.items) ?? []
                    self.albumDetailCell = data
                }
            case .failure(let failure):
                self.showError.toggle()
                print(failure.localizedDescription)
            }
            
        }
    }
    
    
    private func getArtist(audios: [AudioTrackResponse]) -> [TrackModelCell]?{
        var tracks: [TrackModelCell]? = []
        
        for audio in audios {
            
            let artists = audio.artists.compactMap { $0.name }
            let track = TrackModelCell(
                artists: artists.joined(separator: ", "),
                explicit: audio.explicit,
                id: audio.id,
                name: audio.name,
                previewUrl: URL(string: audio.previewUrl ?? "-")
            )
            tracks?.append(track)
        }
        return tracks
    }
}
