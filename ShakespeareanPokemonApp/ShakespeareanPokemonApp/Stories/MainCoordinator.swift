//
//  MainCoordinator.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import UIKit
import ShakespeareanPokemonSDK

struct MainCoordinator {
    private (set) weak var rootController: UINavigationController?
}

// MARK: Start
extension MainCoordinator: CoordinatorProtocol {
    func start() {
        self.flowSearch(animated: false)
    }
}

// MARK: Create
private extension MainCoordinator {
    func createSearch() -> UIViewController {
        let shakespeareanPokemonService = ShakespeareanPokemonService(network: NetworkService())
        let viewModel = SearchViewModel(shakespeareanPokemonService: shakespeareanPokemonService)
        viewModel.output.pokemonData = { pokemonData in
            DispatchQueue.main.async { self.flowDetail(pokemonData: pokemonData) }
        }
        let vc = SearchViewController.createOne(viewModel: viewModel)
        return vc
    }
    
    func createDetail(pokemonData: (name: String, url: URL, text: String)) -> UIViewController {
        let bookmarkService = BookmarkService()
        let viewModel = DetailViewModel(pokemonData: pokemonData,
                                        bookmarkService: bookmarkService)
        let vc = DetailViewController.createOne(viewModel: viewModel)
        return vc
    }
}

// MARK: Flow
private extension MainCoordinator {// flow
    func flowSearch(animated: Bool = true) {
        let vc = self.createSearch()
        self.rootController?.pushViewController(vc, animated: animated)
    }
    
    func flowDetail(pokemonData: (name: String, url: URL, text: String), animated: Bool = true) {
        let vc = self.createDetail(pokemonData: pokemonData)
        self.rootController?.pushViewController(vc, animated: animated)
    }
}
