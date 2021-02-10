//
//  ShakespeareanPokemonServiceProtocol.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import Foundation

protocol ShakespeareanPokemonServiceProtocol {
    func pokemonImage(name: String, completion: @escaping (Result<URL, Error>) -> Void)
    func pokemonShakespeareanDescription(name: String, completion: @escaping (Result<String, Error>) -> Void)
}
