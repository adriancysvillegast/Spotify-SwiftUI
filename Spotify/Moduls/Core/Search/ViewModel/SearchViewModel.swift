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
    
    // MARK: - deinit
    
    deinit {
        print("SearchViewModel Without memory leak")
    }
}
