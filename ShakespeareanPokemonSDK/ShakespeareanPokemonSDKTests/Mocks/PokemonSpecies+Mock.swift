//
//  PokemonSpecies+Mock.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

@testable import ShakespeareanPokemonSDK
import Foundation

extension PokemonSpecies
{
    static func mockWithFlavorText() -> Self {
        .init(
            name: "zubat",
            flavorTextEntries: [
                .init(language: .init(name: "", url: URL(string: "https://www.google.com")!),
                      flavorText: "flavorText1"),
                .init(language: .init(name: "", url: URL(string: "https://www.google.com")!),
                      flavorText: "flavorText2")
            ])
    }
    
    static func mockWithoutFlavorText() -> Self {
        .init(name: "zubat", flavorTextEntries: [])
    }
}

