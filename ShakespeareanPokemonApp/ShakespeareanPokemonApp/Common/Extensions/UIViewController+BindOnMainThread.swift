//
//  UIViewController+BindOnMainThread.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 08/02/21.
//

import UIKit

extension UIViewController {
    class func bindOnMain<T>(_ closure: @escaping (T) -> Void) -> (T) -> Void {
        return { input in
            DispatchQueue.main.async { closure(input) }
        }
    }
}
