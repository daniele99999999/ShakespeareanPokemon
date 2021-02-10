//
//  DetailViewModel.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation
import ShakespeareanPokemonSDK

struct DetailViewModel {
    let input: Input
    let output: Output

    init(pokemonData: (name: String, url: URL, text: String), bookmarkService: BookmarkProtocol) {
        let output = Output()
        self.input = Input(
            ready: Self.ready(pokemonData: pokemonData, bookmarkService: bookmarkService, output: output),
            addToBookmarks: Self.addToBookmarks(name: pokemonData.name, bookmarkService: bookmarkService, output: output),
            removeFromBookmarks: Self.removeFromBookmarks(name: pokemonData.name, bookmarkService: bookmarkService, output: output)
        )
        self.output = output
    }
}

extension DetailViewModel {
    private static func ready(pokemonData: (name: String, url: URL, text: String),
                              bookmarkService: BookmarkProtocol,
                              output: Output) -> VoidClosure {
        return {
            let isBookmarked = bookmarkService.isBookmarked(name: pokemonData.name)
            let bookmarkDescription = Self.buildBookmarkHint(isBookmarked: isBookmarked)
            output.screenTitle?(pokemonData.name)
            output.isBookmarked?(isBookmarked)
            output.bookmarkHint?(bookmarkDescription)
            output.pokemonData?(pokemonData)
        }
    }
    
    private static func addToBookmarks(name: String,
                                       bookmarkService: BookmarkProtocol,
                                       output: Output) -> VoidClosure {
        return {
            bookmarkService.add(name: name)
            let isBookmarked = bookmarkService.isBookmarked(name: name)
            let bookmarkDescription = Self.buildBookmarkHint(isBookmarked: isBookmarked)
            output.isBookmarked?(isBookmarked)
            output.bookmarkHint?(bookmarkDescription)
        }
    }

    private static func removeFromBookmarks(name: String,
                                            bookmarkService: BookmarkProtocol,
                                            output: Output) -> VoidClosure {
        return {
            bookmarkService.remove(name: name)
            let isBookmarked = bookmarkService.isBookmarked(name: name)
            let bookmarkDescription = Self.buildBookmarkHint(isBookmarked: isBookmarked)
            output.isBookmarked?(isBookmarked)
            output.bookmarkHint?(bookmarkDescription)
        }
    }
}

extension DetailViewModel {
    private static func buildBookmarkHint(isBookmarked: Bool) -> String {
        if isBookmarked {
            return NSLocalizedString("Detail.pokemon.Bookmark.on", comment: "")
        } else {
            return NSLocalizedString("Detail.pokemon.Bookmark.off", comment: "")
        }
    }
}

extension DetailViewModel {
    struct Input {
        let ready: VoidClosure
        let addToBookmarks: VoidClosure
        let removeFromBookmarks: VoidClosure
    }

    class Output {
        var screenTitle: VoidOutputClosure<String>?
        var isBookmarked: VoidOutputClosure<Bool>?
        var bookmarkHint: VoidOutputClosure<String>?
        var pokemonData: VoidOutputClosure<(name: String, url: URL, text: String)>?
    }
}

