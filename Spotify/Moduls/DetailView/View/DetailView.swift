//
//  DetailView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 26/11/23.
//

import SwiftUI

struct DetailView: View {
    
    // MARK: - Properties
    var album: NewReleasesModelCell
    @StateObject var viewModel: AlbumDetailViewModel
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical,showsIndicators: false) {
                if viewModel.showError {
//                    showErrorvIEW
                }else if let album = viewModel.albumDetailCell{
                    VStack(spacing: 0) {
                        Group {
                            AlbumHeaderView(albumDetail: album)
                        }
                        .padding(.top, 0)
                        
                        
                        Group {
                            TrackListView(tracks: viewModel.tracks)
                        }
                        .frame(height: CGFloat(viewModel.tracks.count) * 68)
                        
                        
                    }
                }
            }
            
//            ScrollView {
//
//                ZStack {
//
//
//                    if ((viewModel.albumDetailCell?.tracks.isEmpty) != nil ){
//                            // MARK: - Header
//                            AlbumHeaderView(albumDetail: viewModel.albumDetailCell)
//
//                            // MARK: - Music
//                            List {
//                                ForEach(viewModel.albumDetailCell?.tracks ?? [], id: \.id) { track in
//                                    Text(track.name )
//                                }
//                            }
//
//                    } else {
//                        ProgressView()
//                            .progressViewStyle(.circular)
//                    }
//
//                    // MARK: - Body
//                    VStack {
//
//                    }
//
//
//                }
//            }
        }
        .onAppear {
            viewModel.getDetail(album: album)
        }
    }
}

// MARK: - Preview

struct DetailView_Previews: PreviewProvider {
    
    static let album: NewReleasesResponse = Bundle.main.decode("NewReleases.json")
    static let data : [NewReleasesModelCell] = album.albums.items.compactMap {
        NewReleasesModelCell(
            idAlbum: $0.id,
            nameAlbum: $0.name,
            nameArtist: $0.artists.first?.name ?? "--",
            urlImage: URL(string: $0.images.first?.url ?? "--"))
    }
    
    static var previews: some View {
        DetailView(album: data[0], viewModel: AlbumDetailViewModel())
    }
}
