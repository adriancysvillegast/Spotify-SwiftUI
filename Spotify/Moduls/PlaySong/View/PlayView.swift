//
//  PlayView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 30/11/23.
//

import SwiftUI
import MediaPlayer

struct PlayView: View {
    // MARK: - Porperties
    @Binding var id: String
    @StateObject var viewModel: PlaySongViewModel = PlaySongViewModel()
    @State private var volume: Float = AVAudioSession.sharedInstance().outputVolume
    @State private var isPlaying: Bool = false
//    AVAudioSession.sharedInstance().outputVolume
    
    // MARK: - Methods
    
    func chechStatusPlay(track: TrackModelCell) {
        if isPlaying {
            viewModel.tappedPlayPause()
            isPlaying.toggle()
        }else {
            viewModel.playSound(track: track)
            isPlaying.toggle()
        }
        
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .top) {
            if let track = viewModel.songDetail {
                VStack {
                    AsyncImage(url: track.image ) { image in
                        
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                        
                    } placeholder: {
                        VStack {
                            ProgressView()
                                .progressViewStyle(.automatic)
                            Text("Loading")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    
                    VStack {
                        HStack {
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(track.name)
                                        .font(.title)
                                        .foregroundColor(.primary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text(track.artists)
                                        .font(.title3)
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.leading)
                                }
                                
                                Spacer()
                                
                                Button {
                                    print("Add to list or favourite")
                                } label: {
                                    
                                    ZStack(alignment: .center) {
                                        Circle()
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(.primary)
                                        
                                        
                                        
                                        Image(systemName: "star")
                                            .foregroundColor(.primary)
                                        
                                    }
                                    .frame(width: 30, height: 30, alignment: .center)
                                }
                                
                            }
                        }
                        
                        
                        HStack {
                            
                            if track.previewUrl?.absoluteString == "-" {
                                Text("Not available to listen")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }else {
                                Spacer()
                                
                                Button {
                                    //                        restart
                                } label: {
                                    Image(systemName: "backward.fill")
                                        .font(.title)
                                        .foregroundColor(.primary)
                                        .fontWeight(.heavy)
                                }
                                
                                Spacer()
                                
                                Button {
                                    
                                    chechStatusPlay(track: track)
                                } label: {
                                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                        .font(.title)
                                        .foregroundColor(.primary)
                                        .fontWeight(.heavy)
                                }
                                
                                Spacer()
                                
                                Button {
                                    //                        Next
                                } label: {
                                    Image(systemName: "forward.fill")
                                        .font(.title)
                                        .foregroundColor(.primary)
                                        .fontWeight(.heavy)
                                    
                                }
                                Spacer()
                            }
                            
                        }
                        .padding(.top)
                        
                        
                    }
                    
                    
                    HStack {
                        Image(systemName: "speaker.fill")
                        Slider(value: $volume)
                        Image(systemName: "speaker.wave.2.fill")
                    }
                    .padding(.top)
                }
            }else {
                VStack {
                    ProgressView()
                        .progressViewStyle(.circular)
                    Text("Loading Data")
                }
                .padding(.vertical)
                .padding(.horizontal)
                
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            //            aqui comienzo a repproducir la cancion
            Task {
                viewModel.getSong(trackId: id)
            }
            
        }
        
    }
}

