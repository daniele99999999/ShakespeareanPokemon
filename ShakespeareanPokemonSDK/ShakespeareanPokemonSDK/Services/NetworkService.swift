//
//  NetworkService.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

public struct NetworkService {
    let session: URLSession

    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
}

extension NetworkService: NetworkProtocol {
    public func dataTask(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = self.session.dataTask(with: request) { data, response, error in
            guard let status = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.generic))
                return
            }

            switch status.statusCode {
            case 404:
                completion(.failure(NetworkError.notFound))
            case 429:
                completion(.failure(NetworkError.tooManyRequests))
            case 200..<400:
                switch (data, error) {
                case let (_, .some(error)):
                    completion(.failure(error))
                case let (.some(data), .none):
                    completion(.success(data))
                case (.none, .none):
                    completion(.failure(NetworkError.generic))
                }
            default:
                completion(.failure(NetworkError.unsuccesful))
            }
        }
        task.resume()
    }
}

extension NetworkService {
    public enum NetworkError: Error {
        case generic
        case unsuccesful
        case notFound
        case tooManyRequests
    }
}
