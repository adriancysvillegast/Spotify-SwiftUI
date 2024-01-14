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
    @AppStorage("updateLibrary") var updateLibrary: Bool = false
    
    @Published var albumDetailCell: AlbumDetailModelCell?
    @Published var tracks: [TrackModelCell] = []
    @Published var genre: String = "acoustic"
    @Published var recomendedTracks: [TrackModelCell] = []
    @Published var playlistsUser: [ItemModelCell] = []
    @Published var wasAdded: Bool = false
    
    @State var showError: Bool = false
    @State var errorMessage: String = "Ups we got and error\nwhen we were loading data"
    @Published var trackAdded: Bool = false
    @Published var errorAddingToPlaylist: Bool = false
    @Published var successAddingToPlaylist: Bool = false
    // MARK: - Methods
    
    func getDetail(album: ItemModelCell) {
        APIManager.shared.getDetailAlbum(
            album: album
        ) { [weak self] result in
            
            switch result {
            case .success(let value):
                
                    let data = AlbumDetailModelCell(
                        id: value.id,
                        image: album.image,
                        nameAlbum: value.name,
                        nameArtist: value.artists.first?.name ?? "--",
                        tracks: value.tracks.items)
                DispatchQueue.main.async {
                    self?.tracks = self?.getArtist(albumImage: album.image, audios: value.tracks.items) ?? []
                    self?.albumDetailCell = data
                }
            case .failure(let failure):
                self?.showError.toggle()
                self?.errorMessage = failure.localizedDescription
                print(failure.localizedDescription + "hhhjhhh")
            }
            
        }
    }
    
    
    
    
    func getGenresRecomendation() {
        APIManager.shared.getGenres { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.genre = success.genres.randomElement() ?? "acoustic"
                    //                    print(self.genre)
                }
            case .failure(let failure):
                print(failure.localizedDescription + "genres")
            }
        }
    }
    
    func getAudioTrackRecomendations() {
        APIManager.shared.getRecomendationWithAGenre(
            genre: genre
        ) { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    //                    let images
                    self?.recomendedTracks = success.tracks.compactMap({
                        TrackModelCell(
                            image: URL(string: $0.album?.images.first?.url ?? "-"),
                            artists: $0.artists.first?.name ?? "--",
                            explicit: $0.explicit,
                            id: $0.id,
                            name: $0.name,
                            previewUrl: URL(string: $0.album?.images.first?.url ?? "-")
                        )
                    })
                }
            case .failure(let failure):
                print(failure.localizedDescription + "recomendation")
            }
        }
    }
    
    
    private func getArtist(albumImage: URL?,audios: [AudioTrackResponse]) -> [TrackModelCell] {
        var tracks: [TrackModelCell] = []
        
        for audio in audios {
            
            let artists = audio.artists.compactMap { $0.name }
            let track = TrackModelCell(
                image: albumImage,
                artists: artists.joined(separator: ", "),
                explicit: audio.explicit,
                id: audio.id,
                name: audio.name,
                previewUrl: URL(string: audio.previewUrl ?? "-")
            )
            tracks.append(track)
        }
        return tracks
    }
 
    // MARK: - Play songs
    
    func playAllTracks() {
        PlaybackManager.shared.startPlayback(tracks: tracks)
    }
    
    func saveAlbum(album: ItemModelCell) {
        APIManager.shared.saveAlbum(album: album) { [weak self] success in
            DispatchQueue.main.async {
                self?.wasAdded = success
                self?.updateLibrary = success
            }
        }
    }
    
    // MARK: - Review if was added before
    
    func reviewIfWasAddedBefore(album: ItemModelCell) {
        APIManager.shared.getCurrentUserAlbums { [weak self] result in
            switch result {
            case .success(let success):
                let itemsIds = success.compactMap { $0.id }
                DispatchQueue.main.async {
                    self?.wasAdded = itemsIds.contains(album.id)
                }
            case .failure(_):
                print(#function + "error")
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
                                  wasAddedToFavoritePlaylist: false
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
            DispatchQueue.main.async {
                if !success {
                    self.errorAddingToPlaylist.toggle()
                }else {
                    self.successAddingToPlaylist.toggle()
                }
            }
        }
    }
    
    
    deinit {
        print("gooood")
    }
}

