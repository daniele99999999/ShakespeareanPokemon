//
//  PokemonSpecies.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

public struct PokemonSpecies: Codable {
    let name: String
    let flavorTextEntries: [FlavorText]

    struct FlavorText: Codable {
        let language: Language
        let flavorText: String

        enum CodingKeys: String, CodingKey {
            case language
            case flavorText = "flavor_text"
        }
    }

    struct Language: Codable {
        let name: String
        let url: URL
    }

    enum CodingKeys: String, CodingKey {
        case name
        case flavorTextEntries = "flavor_text_entries"
    }
}
