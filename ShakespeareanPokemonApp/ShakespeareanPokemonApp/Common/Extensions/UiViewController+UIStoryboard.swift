//
//  UiViewController+UIStoryboard.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import UIKit

public extension UIViewController {
    class func loadFromStoryboard<T>(storyboardName: String,
                                     viewControllerName: String = String(describing: T.self),
                                     bundle: Bundle? = nil) -> T where T: UIViewController {
        let bundle = Bundle(for: self)
        guard let viewController = UIStoryboard(name: storyboardName, bundle: bundle).instantiateViewController(withIdentifier: viewControllerName) as? T else {
            fatalError("Could not load \(viewControllerName) from \(storyboardName) file.")
        }
        return viewController
    }
}
