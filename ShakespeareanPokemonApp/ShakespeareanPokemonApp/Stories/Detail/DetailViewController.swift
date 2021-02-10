//
//  DetailViewController.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import UIKit
import ShakespeareanPokemonSDK

class DetailViewController: UIViewController {

    @IBOutlet weak var bookmarkHint: UILabel!
    @IBOutlet weak var bookmarkSwitch: UISwitch!
    @IBOutlet weak var pokemonContainerStackView: UIStackView!
    
    private var viewModel: DetailViewModel!
    private var pokemonComponentUI: PokemonComponent!
    
    class func createOne(viewModel: DetailViewModel) -> DetailViewController {
        let vc: DetailViewController = self.loadFromStoryboard(storyboardName: Resources.Interface.main)
        vc.viewModel = viewModel
        vc.pokemonComponentUI = PokemonComponent()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.input.ready()
    }
}

private extension DetailViewController {
    func setupUI() {
        self.showBackArrowOnly()
        //TODO
        self.pokemonContainerStackView.addArrangedSubview(self.pokemonComponentUI.view)
    }
    
    
    func setupBindings() {
        self.bookmarkSwitch.addAction(
            UIAction(
                handler: { [weak self] action in
                    guard let self = self else { return }
                    if self.bookmarkSwitch.isOn {
                        self.viewModel.input.addToBookmarks()
                    } else {
                        self.viewModel.input.removeFromBookmarks()
                    }
                }
            ),
            for: .valueChanged
        )
        
        self.viewModel.output.screenTitle = Self.bindOnMain { [weak self] screenTitle in
            self?.navigationItem.title = screenTitle
        }

        self.viewModel.output.isBookmarked = Self.bindOnMain { [weak self] isBookmarked in
            self?.bookmarkSwitch.setOn(isBookmarked, animated: false)
        }

        self.viewModel.output.bookmarkHint = Self.bindOnMain { [weak self] text in
            self?.bookmarkHint.text = text
        }
        
        self.viewModel.output.pokemonData = Self.bindOnMain { [weak self] data in
            self?.pokemonComponentUI.update(model: PokemonComponent.Model.init(text: data.text, sprite: data.url))
        }
    }
}
