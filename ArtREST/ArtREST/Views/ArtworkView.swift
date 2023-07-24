//
//  ArtworkView.swift
//  ArtREST
//
//  Created by Matheus Freitas Martins on 24/07/23.
//

import SwiftUI

struct ArtworkView: View {
    let artwork: Artwork
    var body: some View {
        NavigationLink {
            ArtworkDetailView(artwork: artwork)
        } label: {
            HStack{
                Text(artwork.title)
            }
        }

    }
}

struct ArtworkView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkView(artwork: previewArtwork)
            .previewLayout(.sizeThatFits)
    }
}
