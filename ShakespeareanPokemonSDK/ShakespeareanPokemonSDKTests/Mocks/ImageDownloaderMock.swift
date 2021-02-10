//
//  ImageDownloaderMock.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

@testable import ShakespeareanPokemonSDK
import Foundation

class ImageDownloaderMock: ImageDownloaderProtocol {
    var _dataTask: ((URL, @escaping (Result<Data, Error>) -> Void) -> Void)?
    func dataTask(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        self._dataTask?(url, completion)
    }
}
