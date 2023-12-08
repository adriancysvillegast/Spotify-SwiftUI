//
//  PlaylistDetailViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 6/12/23.
//

import Foundation
import SwiftUI

class PlaylistDetailViewModel: ObservableObject {
    // MARK: - Properties
    @State var showError: Bool = false
    @Published var playlistDetails: FeaturePlaylistDetailModelCell?
    
    
    
    // MARK: - Methods
    
    func getDetailPlaylist(playlist: PlaylistsModelCell) {
        
        APIManager.shared.getPlaylistDetail(playlistID: playlist.id) { result in
            switch result {
            case .success(let success):
                let track = self.getArtist(audios: success.tracks.items)
                let details = FeaturePlaylistDetailModelCell(
                    id: success.id,
                    image: URL(string: success.images.first?.url ?? "-"),
                    name: success.name,
                    owner: success.owner.displayName,
                    tracks: track,
                    description: success.description
                )
                DispatchQueue.main.async {
                    self.playlistDetails = details
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
                self.showError.toggle()
            }
        }
    }
    
    private func getArtist(audios: [PlaylistItem]) -> [TrackModelCell] {
        var tracks: [TrackModelCell] = []
        
        for audio in audios {
            
            let artists = audio.track.artists.compactMap {$0.name}
            
            let track = TrackModelCell(
                image: URL(string: audio.track.album?.images.first?.url ?? "-"),
                artists: artists.joined(separator: ", "),
                explicit: audio.track.explicit,
                id: audio.track.id,
                name: audio.track.name,
                previewUrl: URL(string: audio.track.previewUrl ?? "-")
            )
            tracks.append(track)
        }
        return tracks
    }
}
