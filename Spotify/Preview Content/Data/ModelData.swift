//
//  ModelData.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 25/11/23.
//

import Foundation


extension Bundle {
    
    func decode<T: Codable>(_ file: String ) -> T {
        // 1. locate the json file
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("faild to locate \(file) in bundle")
        }
        //2. create a propertie for the data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("fatal error to load \(file) from bundle")
        }
        
        //3. create a decoder
        let decoder = JSONDecoder()
        
        //4. create a property
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Faild to decode\(file) from bundle")
        }
        
        //5. return the ready to use data
        return loaded
    }
}
//let previewNewReleases: NewReleasesResponse =
//let value = load("NewReleases.json")

//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//
//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//        else {
//            fatalError("Couldn't find \(filename) in main bundle.")
//    }
//
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}
