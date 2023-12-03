//
//  TrackRecomendationView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 28/11/23.
//

import SwiftUI

struct TrackRecomendationView: View {
    
    // MARK: - Properties
    let tracks: [TrackModelCell]
    let genreName: String
    let cellRow = [GridItem()]
    @State var showTrack: Bool = false
    @State var trackSelected: String = ""
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            if !tracks.isEmpty {
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Button {
                                print("go to a list of songs by the genre \(genreName)")
                            } label: {
                                HStack(spacing: 1) {
                                    Text("Because you love \(genreName)")
                                        .font(.title3)
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.primary)
                                }
                            }
                            Spacer()
                        }
                    }

                    
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: cellRow) {
                                ForEach(tracks, id: \.id) { track in
                                    Button {
                                        showTrack.toggle()
                                        trackSelected = track.id
                                    } label: {
                                        TrackCoverView(track: track)
                                    }
                                }
                            }
                            
                            
                        }
                        .frame(height: 170)
                        .sheet(isPresented: $showTrack) {
                            PlayView(id: $trackSelected, viewModel: PlaySongViewModel())
                        }
                    
                }
            }
        }
        
        .padding(.horizontal)
        
        
        
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
        TrackRecomendationView(tracks: track, genreName: "popded")
    }
}
