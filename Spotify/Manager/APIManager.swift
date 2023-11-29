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
    
    func getDetailAlbum(album: NewReleasesModelCell,
                   completion: @escaping (Result<AlbumsDetailsResponse, Error>) -> Void ) {
        createBaseRequest(
            with: URL(string: basicURL + "/albums/\(album.idAlbum)"),
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
}
