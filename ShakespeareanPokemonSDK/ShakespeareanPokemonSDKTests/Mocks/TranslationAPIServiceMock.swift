//
//  TranslationAPIServiceMock.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

@testable import ShakespeareanPokemonSDK
import Foundation

class TranslationAPIServiceMock: TranslationAPIProtocol {
    var _translate: ((String, @escaping VoidOutputClosure<Result<Translation, Error>>) -> Void)?
    func translate(text: String, completion: @escaping VoidOutputClosure<Result<Translation, Error>>) {
        self._translate?(text, completion)
    }
}
