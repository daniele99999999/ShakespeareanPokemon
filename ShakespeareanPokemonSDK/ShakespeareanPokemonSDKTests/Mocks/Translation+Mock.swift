//
//  Translation+Mock.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

@testable import ShakespeareanPokemonSDK
import Foundation

extension Translation
{
    static func mock() -> Self {
        .init(
            contents: .init(
                translated: "translated",
                text: "text",
                translation: "translation"
            )
        )
    }
}
