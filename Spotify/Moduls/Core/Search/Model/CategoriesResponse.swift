//
//  CategoriesResponse.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/12/23.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: CategoryResponse
}

struct CategoryResponse: Codable {
    let items: [ItemsCategoryResponse]
}

struct ItemsCategoryResponse: Codable {
    let icons: [ItemCategoryResponse]
    let id: String
    let name: String
}
struct ItemCategoryResponse: Codable {
    let url: String
}
