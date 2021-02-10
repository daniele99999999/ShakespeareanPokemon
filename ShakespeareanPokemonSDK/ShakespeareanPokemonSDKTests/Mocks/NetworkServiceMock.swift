//
//  NetworkServiceMock.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

@testable import ShakespeareanPokemonSDK
import Foundation

class NetworkServiceMock: NetworkProtocol {
    var _dataTask: ((URLRequest, @escaping (Result<Data, Error>) -> Void) -> Void)?
    func dataTask(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        self._dataTask?(request, completion)
    }
}
