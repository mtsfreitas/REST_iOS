//
//  ArtworkDetailView.swift
//  ArtREST
//
//  Created by Matheus Freitas Martins on 24/07/23.
//

import SwiftUI

struct ArtworkDetailView: View {
    let artwork: Artwork
    
    var body: some View {
        ScrollView {
            artworkImageView
            // view
            Text(artwork.title)
                .font(.title)
                .padding()
        }
        .navigationTitle("Artwork Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder var artworkImageView: some View {
        if let imageID = artwork.imageId,
           let imageURL = URL(string: "https://www.artic.edu/iiif/2/\(imageID)/full/843,/0/default.jpg") {
            AsyncImage(url: imageURL) { image in
                image.resizable()
                .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
        } else {
            Text("Image is not available")
        }
    }
}

struct ArtworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtworkDetailView(artwork: previewArtwork)
    }
}
