//
//  PokemonAPIServiceMock.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

@testable import ShakespeareanPokemonSDK
import Foundation

class PokemonAPIServiceMock: PokemonAPIProtocol {
    var _pokemonBy: ((String, @escaping VoidOutputClosure<Result<PokemonDetail, Error>>) -> Void)?
    func pokemonBy(name: String, completion: @escaping VoidOutputClosure<Result<PokemonDetail, Error>>) {
        self._pokemonBy?(name, completion)
    }
    
    var _speciesBy: ((String, @escaping VoidOutputClosure<Result<PokemonSpecies, Error>>) -> Void)?
    func speciesBy(name: String, completion: @escaping VoidOutputClosure<Result<PokemonSpecies, Error>>) {
        self._speciesBy?(name, completion)
    }
}
