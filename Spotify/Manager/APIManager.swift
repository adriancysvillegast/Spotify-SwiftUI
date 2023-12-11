//
//  APIManager.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import Foundation

final class APIManager {
    // MARK: - Properties
    static let shared: APIManager = APIManager()
    
    enum HTTPMethods: String {
        case GET
        case PUT
        case POST
        case DELETE
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    private var basicURL: String = ProcessInfo.processInfo.environment["baseURL"] ?? "https://api.spotify.com/v1"
    
    // MARK: - Methods
    
    private func createBaseRequest(with url: URL?, type: HTTPMethods,
                                   completion: @escaping (URLRequest) -> Void) {
        
        AuthManager.shared.withValidToken { token in
            guard let apiUrl = url else {
                return
            }
            
            var request = URLRequest(url: apiUrl)
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            completion(request)
        }
    }
    
    
    // MARK: - NewReleases
    
    func getNewRelease(completion: @escaping ((Result<NewReleasesResponse, Error>) -> Void)) {
        createBaseRequest(
            with: URL(string: basicURL + "/browse/new-releases?limit=50"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    //                    let json = try JSONSerialization.jsonObject(with: data)
                    //                    print(json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(NewReleasesResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
    }
    // MARK: - Details
    
    func getDetailAlbum(album: ItemModelCell,
                        completion: @escaping (Result<AlbumsDetailsResponse, Error>) -> Void ) {
        createBaseRequest(
            with: URL(string: basicURL + "/albums/\(album.id)"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(AlbumsDetailsResponse.self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getGenres(completion: @escaping (Result<GenreResponse, Error>) -> Void) {
        createBaseRequest(
            with: URL(string: basicURL + "/recommendations/available-genre-seeds"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(GenreResponse.self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    
    func getRecomendationWithAGenre(genre: String, completion: @escaping (Result<RecomendationsResponse, Error>) -> Void) {
        createBaseRequest(
            with: URL(string: basicURL + "/recommendations?limit=30&seed_genres=\(genre)"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(RecomendationsResponse.self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    func getSongDetails(id: String, completion: @escaping (Result<AudioTrackResponse, Error>) -> Void ) {
        createBaseRequest(
            with: URL(string: basicURL + "/tracks/\(id)"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(AudioTrackResponse.self, from: data)
                    completion(.success(response))
                    
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    func getFeaturePlaylist(completion: @escaping (Result<FeaturePlaylistResponse, Error>) -> Void) {
        createBaseRequest(
            with: URL(string: basicURL + "/browse/featured-playlists?limit=20"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                                        let json = try JSONSerialization.jsonObject(with: data)
//                                        print(json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(FeaturePlaylistResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getPlaylistDetail(playlistID: String,
                           completion: @escaping (Result<PlaylistDetailResponse, Error>) -> Void ) {
        createBaseRequest(
            with: URL(string: basicURL + "/playlists/\(playlistID)"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                                        let json = try JSONSerialization.jsonObject(with: data)
//                                        print(json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(PlaylistDetailResponse.self, from: data)
//                    print(response)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func getCurrentUserPlaylists(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createBaseRequest(
            with: URL(string: basicURL + "/me/playlists?limit=50"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                                        let json = try JSONSerialization.jsonObject(with: data)
//                                        print(json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(PlaylistsResponse.self, from: data)
                    completion(.success(response.items))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    func getCurrentUserAlbums(completion: @escaping (Result<[AlbumResponse], Error>) -> Void) {
        createBaseRequest(
            with: URL(string: basicURL + "/me/albums?limit=50"),
            type: .GET
        ) { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                                        let json = try JSONSerialization.jsonObject(with: data)
//                                        print(json)
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(LibraryAlbumsResponse.self, from: data)
                    completion(.success(response.items.compactMap({ $0.album })))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func saveAlbum(album: ItemModelCell, completion: @escaping (Bool) -> Void ) {
        createBaseRequest(
            with: URL(string: basicURL + "/me/albums?ids=\(album.id)"),
            type: .PUT) { baseRequest in
                var request = baseRequest
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(
                    with: request) { data, response, error in
                        guard let code = (response as? HTTPURLResponse)?.statusCode,
                              error == nil else {
                            completion(false)
                            return
                        }
                        
                        print(code)
                        completion(code == 200)
                    }
                task.resume()
            }
    }
    
}
