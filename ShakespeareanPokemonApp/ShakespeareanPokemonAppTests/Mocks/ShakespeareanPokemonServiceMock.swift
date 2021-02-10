//
//  ShakespeareanPokemonServiceMock.swift
//  ShakespeareanPokemonAppTests
//
//  Created by daniele salvioni on 10/02/21.
//

@testable import ShakespeareanPokemonApp
@testable import ShakespeareanPokemonSDK
import Foundation

class ShakespeareanPokemonServiceMock: ShakespeareanPokemonServiceProtocol {
    var _pokemonImage: ((String, @escaping (Result<URL, Error>) -> Void) -> Void)?
    func pokemonImage(name: String, completion: @escaping (Result<URL, Error>) -> Void) {
        self._pokemonImage?(name, completion)
    }
    
    var _pokemonShakespeareanDescription: ((String, @escaping (Result<String, Error>) -> Void) -> Void)?
    func pokemonShakespeareanDescription(name: String, completion: @escaping (Result<String, Error>) -> Void) {
        self._pokemonShakespeareanDescription?(name, completion)
    }
}
