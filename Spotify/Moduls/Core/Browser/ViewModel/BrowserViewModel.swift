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
    
    @AppStorage("updateLibrary") var updateLibrary: Bool = false
    
    @Published var newReleasesCell: [ItemModelCell] = []
    @Published var featureListsCell: [ItemModelCell] = []
    @Published var rockListCell: [TrackModelCell] = []
    @Published var alternativeListCell: [TrackModelCell] = []
    @Published var houseListCell: [TrackModelCell] = []
    @Published var genres: [String] = []
    @Published var trackfForGenre: [TrackModelCell] = []
    
    private var albumIdsAdded: [String] = []
    
    @Published var errorAddingToPlaylist: Bool = false
    @Published var errorData: Bool = false
    @Published var errorNameGenres: Bool = false
    @Published var errorTracksByGenres: Bool = false
    
//    tap acctions
    @Published var trackAdded: Bool = false
    @State var wasAddedAlbum: Bool = false
    @State var wasAddedPlaylist: Bool = false
    
    // MARK: - Methods
    
    func getData() {
        errorData = false
        let group = DispatchGroup()
        
        var albumsResponse: [AlbumResponse]?
        var idAlbumsAdded: [String]?
        var playlistResponse: [Playlist]?
        var alternativeResponse: [AudioTrackResponse]?
        var rockResponse: [AudioTrackResponse]?
        var houseResponse: [AudioTrackResponse]?
        
        //User favorite albums ids
        group.enter()
        APIManager.shared.getCurrentUserAlbums { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let item):
                idAlbumsAdded = item.compactMap({ $0.id })
            case .failure(let error):
                print(" ERROR GETTING ALBUMS ADDED FOR USER\(error)")
            }
        }
//        Albums
        group.enter()
        APIManager.shared.getNewRelease { response in
            defer {
                group.leave()
            }
            
            switch response {
            case .success(let result):
                albumsResponse = result.albums.items
            case .failure(let error):
                print("getNewRelease error\(error)")
            }
        }
//        Playlists
        group.enter()
        APIManager.shared.getFeaturePlaylist { response in
            defer {
                group.leave()
            }
            
            switch response {
            case .success(let success):
                playlistResponse = success.playlists.items
            case .failure(let failure):
                print(" playlist error \(failure.localizedDescription)")
            }
        }
        
        //        Alternative
        group.enter()
        APIManager.shared.getRecomendationWithAGenre(
            genre: Constants.alternative) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let success):
                    alternativeResponse = success.tracks
                case .failure(let failure):
                    print(" getRecomendationWithAGenre \(failure.localizedDescription)")
                }
            }
        
        
//        Hard-rock
        group.enter()
        APIManager.shared.getRecomendationWithAGenre(
            genre: Constants.hardRock) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let success):
                    rockResponse = success.tracks
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
//        House
        group.enter()
        APIManager.shared.getRecomendationWithAGenre(
            genre: Constants.house) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let success):
                    houseResponse = success.tracks
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        
        
        group.notify(queue: .main) {
            guard let albums = albumsResponse, let idsAlbumsAdded = idAlbumsAdded, let playlists = playlistResponse, let rock = rockResponse, let alternative = alternativeResponse, let house = houseResponse else {
                self.errorData = true
                return
            }
            self.configureData(albums: albums, idAlbumAdded: idsAlbumsAdded, playlist: playlists, rock: rock, alternative: alternative, house: house)
        }
    }
    
    private func configureData(
        albums: [AlbumResponse],
        idAlbumAdded: [String],
        playlist: [Playlist],
        rock: [AudioTrackResponse],
        alternative: [AudioTrackResponse],
        house: [AudioTrackResponse]
    ) {
        
//        Albums
        let albumCell = albums.compactMap {
            ItemModelCell(
                id: $0.id,
                nameItem: $0.name,
                creatorName: $0.artists.first?.name ?? "-",
                image: URL(string: $0.images.first?.url ?? "-"),
                description: "",
                isPlaylist: false,
                wasAddedToFavoriteAlbums: false,
                wasAddedToFavoritePlaylist: false //idAlbumAdded.contains($0.id)
            )
        }
        
        albumIdsAdded = idAlbumAdded
//        playlist
        let playlistsCell = playlist.compactMap {
            ItemModelCell(
                id: $0.id,
                nameItem: $0.name,
                creatorName: $0.owner.displayName,
                image: URL(string: $0.images.first?.url ?? "-"),
                description: $0.description,
                isPlaylist: true,
                wasAddedToFavoriteAlbums: false,
                wasAddedToFavoritePlaylist: false
            )
        }
        
//        Rock
        let rockCell = rock.compactMap {
            TrackModelCell(
                image: URL(string: $0.album?.images.first?.url ?? "-"),
                artists: $0.artists.first?.name ?? "-",
                explicit: $0.explicit,
                id: $0.id,
                name: $0.name,
                previewUrl: URL(string: $0.previewUrl ?? "-")
            )
        }
        
//        House
        let houseCell = house.compactMap {
            TrackModelCell(
                image: URL(string: $0.album?.images.first?.url ?? "-"),
                artists: $0.artists.first?.name ?? "-",
                explicit: $0.explicit,
                id: $0.id,
                name: $0.name,
                previewUrl: URL(string: $0.previewUrl ?? "-")
            )
        }
//        Alternative
        let alternativeCell = alternative.compactMap {
            TrackModelCell(
                image: URL(string: $0.album?.images.first?.url ?? "-"),
                artists: $0.artists.first?.name ?? "-",
                explicit: $0.explicit,
                id: $0.id,
                name: $0.name,
                previewUrl: URL(string: $0.previewUrl ?? "-")
            )
        }
        
        DispatchQueue.main.async {
            self.newReleasesCell = albumCell
            self.featureListsCell = playlistsCell
            self.rockListCell = rockCell
            self.alternativeListCell = alternativeCell
            self.houseListCell = houseCell
        }
        
        
    }
                
    
    // MARK: - Add To Favorite tracks
    
    func addToFavoriteTracks(trackId: String) {
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
    
    // MARK: - Add album to favorite
    
    func addAlbumTofavorite(album: ItemModelCell) {
        APIManager.shared.saveAlbum(album: album) { [weak self] success in
            DispatchQueue.main.async {
                self?.wasAddedAlbum = success
                self?.updateLibrary = success
                self?.updateAlbum(album: album)
            }
        }
    }
    
    func updateAlbum(album: ItemModelCell) {
//        self.newReleasesCell.forEach { value in
//            if value.id == album.id {
//                value.wasAddedToFavoriteAlbums.toggle()
//            }
//        }
    }
    
    func albumWasAdded(album: ItemModelCell) -> Bool {
        self.albumIdsAdded.contains { id in
            id == album.id
        }
    }
    
    // MARK: - More to Explore
    
    func getGenres() {
        APIManager.shared.getGenres { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.genres = success.genres
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.errorNameGenres.toggle()
            }
        }
    }
    
    func getTracksByGenre(genre: String) {
        APIManager.shared.getRecomendationWithAGenre(genre: genre) { [weak self] result in
            switch result {
            case .success(let success):
                
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
                    self?.trackfForGenre =  tracks
                }
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.errorTracksByGenres.toggle()
            }
        }
    }
    
    deinit {
        print("BrowserViewModel withOut memory leak")
    }
}
