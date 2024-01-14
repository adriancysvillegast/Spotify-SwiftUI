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
    @Published var allTracks: [TrackModelCell] = []
    @Published var playlistsUser: [ItemModelCell] = []
    @State var errorAddingToPlaylist: Bool = false
    @Published var errorCreatingPlaylist: Bool = false
    @Published var wasAdded: Bool = false
    @Published var trackAdded: Bool = false
    // MARK: - Methods
    
    
    func getDetailPlaylist(playlist: ItemModelCell) {
        
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
                    self.allTracks = track
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
    
    
    // MARK: - Play Music
    func playListOfTracks() {
        PlaybackManager.shared.startPlayback(tracks: allTracks)
    }
    
    func shufflePlaylistTracks() {
        PlaybackManager.shared.startPlaybackShuffle(tracks: allTracks)
    }
    
    // MARK: - Add to playlists

    func getUserPlaylists() {
        
        APIManager.shared.getCurrentUserPlaylists { [weak self] result in
            switch result {
            case .success(let success):
                let playlists = success.compactMap {
                    ItemModelCell(id: $0.id,
                                  nameItem: $0.name,
                                  creatorName: $0.owner.displayName,
                                  image: URL(string: $0.images.first?.url ?? "-"),
                                  description: $0.description,
                                  isPlaylist: true,
                                  wasAddedToFavoriteAlbums: false,
                                  wasAddedToFavoritePlaylist: true
                    )
                }
                DispatchQueue.main.async {
                    self?.playlistsUser = playlists
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.showError.toggle()
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
    
}
