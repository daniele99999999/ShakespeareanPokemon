//
//  SearchViewController.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchInput: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    private (set) var viewModel: SearchViewModel!
    
    class func createOne(viewModel: SearchViewModel) -> SearchViewController {
        let vc: SearchViewController = self.loadFromStoryboard(storyboardName: Resources.Interface.main)
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
        
        self.viewModel.input.ready()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
    }
}

private extension SearchViewController {
    func setupUI() {
        self.showBackArrowOnly()
        // TODO
    }
    
    func setupBindings() {
        self.searchButton.addAction(
            UIAction(
                handler: { [weak self] action in
                    guard let name = self?.searchInput.text else { return }
                    self?.viewModel.input.search(name)
                }
            ),
            for: .touchUpInside
        )
        
        self.viewModel.output.screenTitle = Self.bindOnMain { [weak self] screenTitle in
            self?.navigationItem.title = screenTitle
        }
        
        self.viewModel.output.searchInputPlaceholder = Self.bindOnMain { [weak self] placeholder in
            self?.searchInput.placeholder = placeholder
        }
        
        self.viewModel.output.searchButtonTitle = Self.bindOnMain { [weak self] buttonTitle in
            self?.searchButton.setTitle(buttonTitle, for: .normal)
        }
        
        self.viewModel.output.isLoading = Self.bindOnMain { [weak self] isLoading in
            if isLoading {
                self?.activityView.startAnimating()
            } else {
                self?.activityView.stopAnimating()
            }
            self?.activityView.isHidden = !isLoading
        }
        
        self.viewModel.output.error = Self.bindOnMain { [weak self] data in
            self?.showErrorAlert(title: data.title, message: data.message, confirmTitle: data.confirmTitle)
        }
    }
}

private extension SearchViewController {
    func showErrorAlert(title: String, message: String, confirmTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(.init(title: confirmTitle, style: .default))
        self.present(alert, animated: true)
    }
}
