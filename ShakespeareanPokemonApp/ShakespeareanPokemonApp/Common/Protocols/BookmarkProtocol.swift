//
//  BookmarkProtocol.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import Foundation

protocol BookmarkProtocol {
    func isBookmarked(name: String) -> Bool
    func add(name: String)
    func remove(name: String)
}
