//
//  PokemonDetail+Mock.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

@testable import ShakespeareanPokemonSDK
import Foundation

extension PokemonDetail
{
    static func mockWithOfficialArtwork() -> Self {
        .init(
            id: 0,
            name: "zubat",
            sprites: .init(
                frontDefault: URL(string: "https://www.frontDefault.com")!,
                frontShiny: nil,
                backDefault: nil,
                backShiny: nil,
                officialArtwork: URL(string: "https://www.officialArtwork.com")!
            )
        )
    }
    
    static func mockWithoutOfficialArtwork() -> Self {
        .init(
            id: 0,
            name: "zubat",
            sprites: .init(
                frontDefault: URL(string: "https://www.frontDefault.com")!,
                frontShiny: nil,
                backDefault: nil,
                backShiny: nil,
                officialArtwork: nil
            )
        )
    }
}
