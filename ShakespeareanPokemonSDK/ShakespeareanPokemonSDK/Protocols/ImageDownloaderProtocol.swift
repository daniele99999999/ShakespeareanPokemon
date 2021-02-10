//
//  PokemonComponentProtocol.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import UIKit

public protocol ImageDownloaderProtocol {
    func dataTask(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
