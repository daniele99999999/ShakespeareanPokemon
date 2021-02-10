//
//  SearchViewModel.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation
import ShakespeareanPokemonSDK

struct SearchViewModel {
    let input: Input
    let output: Output

    init(shakespeareanPokemonService: ShakespeareanPokemonServiceProtocol) {
        let output = Output()
        self.input = Input(
            ready: Self.ready(output: output),
            search: Self.search(shakespeareanPokemonService: shakespeareanPokemonService, output: output)
        )
        self.output = output
    }
}

private extension SearchViewModel {
    
    private static func ready(output: Output) -> VoidClosure {
        return {
            output.screenTitle?(NSLocalizedString("Search.title", comment: ""))
            output.searchInputPlaceholder?(NSLocalizedString("Search.textfield.placeholder", comment: ""))
            output.searchButtonTitle?(NSLocalizedString("Search.button.title", comment: ""))
            output.isLoading?(false)
        }
    }
    
    private static func search(shakespeareanPokemonService: ShakespeareanPokemonServiceProtocol,
                               output: Output) -> VoidOutputClosure<String> {
        return { name in
            output.isLoading?(true)

            _ = shakespeareanPokemonService.pokemonImage(name: name) { imageResult in
                output.isLoading?(false)

                switch imageResult {
                case .success(let url):
                    output.isLoading?(true)
                    shakespeareanPokemonService.pokemonShakespeareanDescription(name: name) { translationResult in
                        output.isLoading?(false)
                        switch translationResult {
                        case .success(let text):
                            output.pokemonData?((name: name, url: url, text: text))
                        case .failure(NetworkService.NetworkError.tooManyRequests):
                            output.error?(
                                (
                                    title: NSLocalizedString("Error.alert.title", comment: ""),
                                    message: NSLocalizedString("Error.translationAPI.tooManyRequests", comment: ""),
                                    confirmTitle: NSLocalizedString("Error.alert.button.ok", comment: "")
                                )
                            )
                        case .failure:
                            output.error?(
                                (
                                    title: NSLocalizedString("Error.alert.title", comment: ""),
                                    message: NSLocalizedString("Error.translationAPI.unknown", comment: ""),
                                    confirmTitle: NSLocalizedString("Error.alert.button.ok", comment: "")
                                )
                            )
                        }
                    }
                case .failure(NetworkService.NetworkError.notFound):
                    output.error?(
                        (
                            title: NSLocalizedString("Error.alert.title", comment: ""),
                            message: NSLocalizedString("Error.pokemonAPI.notFound", comment: ""),
                            confirmTitle: NSLocalizedString("Error.alert.button.ok", comment: "")
                        )
                    )
                case .failure:
                    output.error?(
                        (
                            title: NSLocalizedString("Error.alert.title", comment: ""),
                            message: NSLocalizedString("Error.pokemonAPI.unknown", comment: ""),
                            confirmTitle: NSLocalizedString("Error.alert.button.ok", comment: "")
                        )
                    )
                }
            }
        }
    }
}

extension SearchViewModel {
    struct Input {
        let ready: VoidClosure
        let search: VoidOutputClosure<String>
    }

    class Output {
        var screenTitle: VoidOutputClosure<String>?
        var searchInputPlaceholder: VoidOutputClosure<String>?
        var searchButtonTitle: VoidOutputClosure<String>?
        var isLoading: VoidOutputClosure<Bool>?
        var error: VoidOutputClosure<(title: String, message: String, confirmTitle: String)>?
        var pokemonData: VoidOutputClosure<(name: String, url: URL, text: String)>?
    }
}

