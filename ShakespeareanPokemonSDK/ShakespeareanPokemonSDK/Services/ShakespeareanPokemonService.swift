//
//  ShakespeareanPokemonService.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

public struct ShakespeareanPokemonService {
    let pokemonAPI: PokemonAPIProtocol
    let translationAPI: TranslationAPIProtocol

    public init(pokemonAPI: PokemonAPIProtocol, translationAPI: TranslationAPIProtocol) {
        self.pokemonAPI = pokemonAPI
        self.translationAPI = translationAPI
    }

    public init(network: NetworkProtocol = NetworkService()) {
        self.pokemonAPI = PokemonAPIService(baseURL: Resources.Api.pokemonBaseURL,
                                            network: network)
        self.translationAPI = TranslationAPIService(baseURL: Resources.Api.translationBaseURL,
                                                    network: network)
    }
   
    public func pokemonImage(name: String, completion: @escaping (Result<URL, Error>) -> Void) {
        self.pokemonAPI.pokemonBy(name: name) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let pokemonDetail):
                completion(.success(pokemonDetail.sprites.mainSprite))
            }
        }
    }

    public func pokemonShakespeareanDescription(name: String, completion: @escaping (Result<String, Error>) -> Void) {
        self.pokemonAPI.speciesBy(name: name) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let pokemonSpecies):
                guard let text = pokemonSpecies.flavorTextEntries.first?.flavorText else {
                    completion(.success(""))
                    return
                }
                
                // remove \n for make translation service works
                let sanitisedText = text.trimmingCharacters(in: CharacterSet.newlines).replacingOccurrences(of: "\n", with: " ")
                self.translationAPI.translate(text: sanitisedText) { result in
                    switch result {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let translation):
                        completion(.success(translation.contents.translated))
                    }
                }
            }
        }
    }
}
