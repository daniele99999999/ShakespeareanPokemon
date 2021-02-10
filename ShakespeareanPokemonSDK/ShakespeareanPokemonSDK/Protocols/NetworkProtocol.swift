//
//  NetworkProtocol.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 06/02/21.
//

import Foundation

public protocol NetworkProtocol {
    func dataTask(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}

public extension NetworkProtocol {
    func dataTask(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        self.dataTask(request: request, completion: completion)
    }
}
