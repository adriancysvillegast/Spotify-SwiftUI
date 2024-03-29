//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/12/23.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var genres: [String] = []
    @Published var categories: [CategoriesModelCell] = []
    @Published var singleCategory: CategoriesModelCell?
    @Published var searching: Bool = false
    
    @Published var tracksModel: [TrackModelCell] = []
    @Published var artistModel: [ArtistModelCell] = []
    @Published var albumsModel: [ItemModelCell] = []
    
    @Published var artistDetail: ArtistModelCell?
    @Published var topTracksByArtist: [TrackModelCell] = []
    @Published var artistDone: Bool = false
    @Published var albumsByArtist: [ItemModelCell] = []
    // MARK: - Methods
    
    func getGenres() {
        APIManager.shared.getGenres { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.genres = success.genres
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: - Categories
    
    func getCategories() {
        APIManager.shared.getCategories { [weak self] result in
            switch result {
            case .success(let success):
                let categories = success.categories.items.compactMap({
                    CategoriesModelCell(id: $0.id,
                                        name: $0.name,
                                        artwork: URL(string: $0.icons.first?.url ?? "-")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.categories = categories
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getCategoryDetail(idCategory: String) {
        APIManager.shared.getCategoryDetail(
            id: idCategory) { [weak self] result in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        guard ((self?.singleCategory = CategoriesModelCell(
                            id: success.id,
                            name: success.name,
                            artwork: URL(string: success.icons.first?.url ?? "-")
                        )) != nil) else {
                           return
                       }
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
    }
    
    
    // MARK: - Search
    
    func getSearchResult(searchTerm: String) {
        
//        searching.toggle()
        APIManager.shared.getSearch(
            query: searchTerm) { [weak self] result in
                switch result {
                case .success(let data):
                    let tracks = self?.getTracksModel(data: data)
                    let artists = self?.getArtistModel(data: data)
                    let albums = self?.getAlbumsModel(data: data)
                    DispatchQueue.main.async {
                        self?.tracksModel = tracks ?? []
                        self?.artistModel = artists ?? []
                        self?.albumsModel = albums ?? []
//                        print(self?.tracksModel)
                    }
                    
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
    }
    
    func clearProperties(query: String) {
        if query == "" {
            tracksModel = []
            artistModel = []
            albumsModel = []
        }
        
    }
    
    func getTracksModel(data: SearchResultResponse) -> [TrackModelCell] {
       let tracks = data.tracks.items.compactMap {
            TrackModelCell(
                image: URL(string: $0.album?.images.first?.url ?? "-"),
                artists: $0.artists.first?.name ?? "-",
                explicit: $0.explicit,
                id: $0.id,
                name: $0.name,
                previewUrl: URL(string: $0.previewUrl ?? "-"))
        }
        
        return tracks
    }
    
    func getArtistModel(data: SearchResultResponse) -> [ArtistModelCell] {
        let artists = data.artists.items.compactMap {
            ArtistModelCell(
                id: $0.id,
                name: $0.name,
                artwork: URL(string: $0.images?.first?.url ?? "-"),
                genres: "",
                followers: ""
            )
        }
        return artists
    }
    
    func getAlbumsModel(data: SearchResultResponse) -> [ItemModelCell] {
        let albums = data.albums.items.compactMap {
            ItemModelCell(
                id: $0.id,
                nameItem: $0.name,
                creatorName: $0.artists.first?.name ?? "-",
                image: URL(string: $0.images.first?.url ?? "-"),
                description: "",
                isPlaylist: false,
                wasAddedToFavoriteAlbums: false,
                wasAddedToFavoritePlaylist: false
            )
        }
        return albums
    }
    
    // MARK: - ArtistDetail
    
    func getArtistDetail(id: String) {
        APIManager.shared.getArtistDetail(id: id) { [weak self] result in
            switch result {
            case .success(let success):
                let artistDetail = ArtistModelCell(
                    id: success.id,
                    name: success.name,
                    artwork: URL(string: success.images?.first?.url ?? "-"),
                    genres: success.genres.joined(separator: ", "),
                    followers: String(success.followers.total)
                )
                DispatchQueue.main.async {
                    self?.artistDetail = artistDetail
                    self?.artistDone = true
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        
        APIManager.shared.getTopTracksByArtist(id: id) { [weak self] result in
            switch result {
            case .success(let success):
                let tracks = success.tracks.compactMap {
                    TrackModelCell(
                        image: URL(string: $0.album.images.first?.url ?? "-"),
                        artists: $0.artists.first?.name ?? "-",
                        explicit: $0.explicit,
                        id: $0.id,
                        name: $0.name,
                        previewUrl: URL(string: $0.previewUrl ?? "-"))
                }
                
                DispatchQueue.main.async {
                    self?.topTracksByArtist = tracks
                }
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
        APIManager.shared.getTopAlbumsByArtist(id: id) { [weak self] result in
            switch result {
            case .success(let success):
                let albums = success.items.compactMap {
                    ItemModelCell(
                        id: $0.id,
                        nameItem: $0.name,
                        creatorName: $0.artists.first?.name ?? "-",
                        image: URL(string: $0.images.first?.url ?? "-"),
                        description: "",
                        isPlaylist: false,
                        wasAddedToFavoriteAlbums: false,
                        wasAddedToFavoritePlaylist: false
                    )
                }
                DispatchQueue.main.async {
                    self?.albumsByArtist = albums
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: - deinit
    
    deinit {
        print("SearchViewModel Without memory leak")
    }
}
