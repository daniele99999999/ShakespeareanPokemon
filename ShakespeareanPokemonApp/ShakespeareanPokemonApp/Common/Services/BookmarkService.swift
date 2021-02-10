//
//  BookmarkService.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

struct BookmarkService {
    private let userDefaults = UserDefaults.standard
}

extension BookmarkService: BookmarkProtocol
{
    func isBookmarked(name: String) -> Bool {
        return self.userDefaults.bool(forKey: name)
    }

    func add(name: String) {
        self.userDefaults.setValue(true, forKey: name)
    }

    func remove(name: String) {
        self.userDefaults.removeObject(forKey: name)
    }
}
