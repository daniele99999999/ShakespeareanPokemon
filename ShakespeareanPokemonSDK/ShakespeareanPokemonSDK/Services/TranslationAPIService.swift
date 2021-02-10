//
//  TranslationAPI.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 07/02/21.
//

import Foundation

struct TranslationAPIService {
    let baseURL: URL
    let network: NetworkProtocol

    init(baseURL: URL, network: NetworkProtocol) {
        self.baseURL = baseURL
        self.network = network
    }
}

extension TranslationAPIService {
    enum Endpoints {
        case translate

        var path: String {
            switch self {
            case .translate:
                return "translate/shakespeare.json"
            }
        }

        func url(baseURL: URL) -> URL {
            baseURL.appendingPathComponent(self.path)
        }
    }
}

extension TranslationAPIService: APIHandleResponseProtocol {}
extension TranslationAPIService: TranslationAPIProtocol {
    func translate(text: String,
                   completion: @escaping VoidOutputClosure<Result<Translation, Error>>) {
        let url = Endpoints.translate.url(baseURL: baseURL)
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "text", value: text)]
        guard let urlComponentsData = urlComponents.query?.data(using: .utf8) else {
            completion(.failure(SDKError.invalidParameters(message: "could not encode data")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        request.httpBody = urlComponentsData

        self.network.dataTask(request: request,
                              completion: self.handleResponse(completion: completion))
    }
}
