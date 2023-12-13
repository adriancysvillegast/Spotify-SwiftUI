//
//  LabelTrackView.swift
//  Spotify
//
//  Created by Adriancys Jesus Villegas Toro on 13/12/23.
//

import SwiftUI

struct LabelTrackView: View {
    // MARK: - Property
    let track: TrackModelCell
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(track.name)
                    .font(.title3)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                if track.explicit {
                    Image(systemName: "e.square.fill")
                        .foregroundColor(.primary)
                }
            }

            Text(track.artists)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

//struct LabelTrackView_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelTrackView()
//    }
//}
