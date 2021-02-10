//
//  Errors.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

public enum SDKError: Error {
    case invalidParameters(rawURL: String? = nil, message: String? = nil)
}
