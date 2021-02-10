//
//  Translation.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

public struct Translation: Codable {
    let contents: Contents

    struct Contents: Codable {
        let translated: String
        let text: String
        let translation: String
    }
}
