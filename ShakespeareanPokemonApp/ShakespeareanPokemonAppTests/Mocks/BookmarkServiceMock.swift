//
//  BookmarkServiceMock.swift
//  ShakespeareanPokemonAppTests
//
//  Created by daniele salvioni on 10/02/21.
//

@testable import ShakespeareanPokemonApp
@testable import ShakespeareanPokemonSDK
import Foundation

class BookmarkServiceMock: BookmarkProtocol {
    
    var list = [String: Bool]()
    
    func isBookmarked(name: String) -> Bool {
        return self.list[name] ?? false
    }
    
    func add(name: String) {
        self.list[name] = true
    }
    
    func remove(name: String) {
        self.list[name] = nil
    }
}

