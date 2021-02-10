//
//  PokemonAPIService.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

struct PokemonAPIService {
    let baseURL: URL
    let network: NetworkProtocol

    init(baseURL: URL, network: NetworkProtocol) {
        self.baseURL = baseURL
        self.network = network
    }
}

extension PokemonAPIService {
    enum Endpoints {
        case species
        case pokemon

        var path: String {
            switch self {
            case .species:
                return "pokemon-species"
            case .pokemon:
                return "pokemon"
            }
        }

        func url(baseURL: URL) -> URL {
            baseURL.appendingPathComponent(self.path)
        }
    }
}

extension PokemonAPIService: APIHandleResponseProtocol {}
extension PokemonAPIService: PokemonAPIProtocol {
    func pokemonBy(name: String,
                   completion: @escaping VoidOutputClosure<Result<PokemonDetail, Error>>) {
        let url = Endpoints.pokemon.url(baseURL: baseURL).appendingPathComponent(name)
        let request = URLRequest(url: url)
        self.network.dataTask(request: request,
                              completion: self.handleResponse(completion: completion))
    }

    func speciesBy(name: String,
                   completion: @escaping VoidOutputClosure<Result<PokemonSpecies, Error>>) {
        let url = Endpoints.species.url(baseURL: baseURL).appendingPathComponent(name)
        let request = URLRequest(url: url)
        self.network.dataTask(request: request,
                              completion: self.handleResponse(completion: completion))
    }
}


