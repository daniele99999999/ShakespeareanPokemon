//
//  ApiProtocol.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 06/02/21.
//

import Foundation

public protocol APIHandleResponseProtocol {
    func handleResponse<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void
}

public extension APIHandleResponseProtocol {
    func handleResponse<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void {
        return { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                } catch let decodeError {
                    completion(.failure(decodeError))
                }
            case .failure(let responseError):
                completion(.failure(responseError))
            }
        }
    }
}

public protocol PokemonAPIProtocol {
    func pokemonBy(name: String,
                   completion: @escaping VoidOutputClosure<Result<PokemonDetail, Error>>)

    func speciesBy(name: String,
                   completion: @escaping VoidOutputClosure<Result<PokemonSpecies, Error>>)
}

public protocol TranslationAPIProtocol {
    func translate(text: String,
                   completion: @escaping VoidOutputClosure<Result<Translation, Error>>)
}
