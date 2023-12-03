//
//  VolumenManager.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 30/11/23.
//

import Foundation
import MediaPlayer
import SwiftUI


final class VolumenManager: ObservableObject {
    
    // MARK: - Properties
    @State var volume: Float = AVAudioSession.sharedInstance().outputVolume
    
    // Audio session object
    private let session = AVAudioSession.sharedInstance()
    
    // Observer
    private var progressObserver: NSKeyValueObservation!
    
    // MARK: - Methods
    
    func subscribe() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("cannot activate session")
        }

        progressObserver = session.observe(\.outputVolume) { [self] (session, value) in
            DispatchQueue.main.async {
                self.volume = session.outputVolume
            }
        }
    }

    func unsubscribe() {
        self.progressObserver.invalidate()
    }

    init() {
        subscribe()
    }
}
