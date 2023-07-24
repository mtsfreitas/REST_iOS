//
//  ArtworkViewModel.swift
//  ArtREST
//
//  Created by Matheus Freitas Martins on 24/07/23.
//

import Combine
import Foundation

class ArtworkViewModel: ObservableObject {
    @Published private(set) var artworks = [Artwork]()
    private var cancellables = Set<AnyCancellable>()
    private let jsonDecoder = JSONDecoder()
    
    func fetchArtwork() {
        guard let url = URL(string: "https://api.artic.edu/api/v1/artworks") else { return }
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ArtworkDataResponse.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    print("Fim")
                }
            } receiveValue: { [weak self] response in
                self?.artworks = response.data
            }
            .store(in: &cancellables)
    }
}
