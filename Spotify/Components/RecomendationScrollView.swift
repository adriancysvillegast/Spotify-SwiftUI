//
//  RecomendationScrollView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 28/11/23.
//

import SwiftUI

struct RecomendationScrollView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: BrowserViewModel = BrowserViewModel()
    let tracks: [TrackModelCell]
    let genreName: String
    let cellRow = [GridItem()]
    let title: String
    @State var showTrack: Bool = false
    @State var trackSelectedId: String = "no"
    @State var trackSelectedName: String = "no"
    @State var showUserPlaylists: Bool = false
    @State var tappedTrack: Bool = false
    
    func hiddenIcon() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.6) {
            tappedTrack.toggle()
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            if !tracks.isEmpty {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            // MARK: - Button
                            NavigationLink {
                                TracksListVerticalView(tracks: tracks, genreName: genreName)
                            } label: {
                                HStack(spacing: 1) {
                                    
                                    Text("\(title) \(genreName.capitalized)")
                                        .font(.title2)
                                        .foregroundColor(.primary)

                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.primary)
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    // MARK: - Cover albums or tracks
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: cellRow) {
                            ForEach(tracks, id: \.id) { track in
                                Button {
                                    showTrack.toggle()
                                    trackSelectedId = track.id
                                } label: {
                                    TrackCoverView(track: track)
                                        .contextMenu {
                                            Button {
                                                trackSelectedId = track.id
                                                trackSelectedName = track.name
                                                self.showUserPlaylists.toggle()
                                            } label: {
                                                TitleButtonContexMenuView(name: "Add to a Playlist", icon: "star")
                                            }
                                        
                                            Button {
                                                viewModel.addToFavoriteTracks(trackId: track.id)
                                                tappedTrack.toggle()
                                                hiddenIcon()
                                            } label: {
                                                TitleButtonContexMenuView(name: "Favorite", icon: "heart")
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                    .sheet(isPresented: $showTrack) {
                        PlayView(id: $trackSelectedId)
                    }
                    .fullScreenCover(isPresented: $showUserPlaylists) {
        //                show a view with the playlist by user
                        UserPlaylistAVMView(idTrack: $trackSelectedId, nameTrack: $trackSelectedName)
                    }
                    
                }
            }
        }
        .overlay {
            ZStack {
                Image(systemName: "heart")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .opacity(tappedTrack ? 1.0 : 0.0)
                    .animation(.easeOut(duration: 0.4), value: tappedTrack)   
            }
        }
        
    }
}

struct TrackRecomendationView_Previews: PreviewProvider {
    static let track: [TrackModelCell] = [
        TrackModelCell(image: URL(string: "https://i.scdn.co/image/ab67616d0000b2737585dc8eef094d400fd3c1a6"), artists: "dad", explicit: true, id: "ss", name: "fechcfgoriasjsjdjdjdjajdjjdjjdajdj", previewUrl: URL(string: "jhshf")),
        TrackModelCell(image: URL(string: "https://i.scdn.co/image/ab67616d0000b2737585dc8eef094d400fd3c1a6"), artists: "feid", explicit: true, id: "sdsd", name: "fechoriasadmaldmaldmaldmladmlamdladmldldmaldmalm", previewUrl: URL(string: "jhshf")),
        
        TrackModelCell(image: URL(string: "https://i.scdn.co/image/ab67616d0000b2737585dc8eef094d400fd3c1a6"), artists: "feid", explicit: true, id: "sfgdsd", name: "fechorias", previewUrl: URL(string: "jhshf")),
        TrackModelCell(image: URL(string: "https://i.scdn.co/image/ab67616d0000b2737585dc8eef094d400fd3c1a6"), artists: "f.kkk.eid", explicit: true, id: "sdlksd", name: "fechorias", previewUrl: URL(string: "jhshf")),
        
        TrackModelCell(image: URL(string: "https://i.scdn.co/image/ab67616d0000b2737585dc8eef094d400fd3c1a6"), artists: "czczc", explicit: true, id: "sdsd", name: "fechorias", previewUrl: URL(string: "jhshf"))
    ]
    static var previews: some View {
        RecomendationScrollView(tracks: track, genreName: "popded", title: "Top")
    }
}
