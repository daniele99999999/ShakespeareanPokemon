//
//  ApiDecodingTests.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

import XCTest
@testable import ShakespeareanPokemonSDK

class ApiDecodingTests: XCTestCase {

    let pokemonByNameDataMock: Data = StorageUtils.loadJSON(name: "PokemonByNameMock", bundle: Bundle(for: ApiDecodingTests.self))!
    let speciesByNameMockDataMock: Data = StorageUtils.loadJSON(name: "SpeciesByNameMock", bundle: Bundle(for: ApiDecodingTests.self))!
    let translateTextDataMock: Data = StorageUtils.loadJSON(name: "TranslateTextMock", bundle: Bundle(for: ApiDecodingTests.self))!
   
    func testApiDecodingPokemonByName() {
        
        let expectation = self.expectation(description: "testApiDecodingPokemonByName")
        
        let url = URL(string: "https://www.google.com")!
        let name = "zubat"
        let networkServiceMock = NetworkServiceMock()
        networkServiceMock._dataTask = { _, completion in
            completion(.success(self.pokemonByNameDataMock))
        }
        
        let apiService = PokemonAPIService(baseURL: url, network: networkServiceMock)
        apiService.pokemonBy(name: name) { result in
            let data = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(data.name, "zubat")
            // TODO: check all properties
        }
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testApiDecodingSpeciesByName() {
        let expectation = self.expectation(description: "testApiDecodingSpeciesByName")
        
        let url = URL(string: "https://www.google.com")!
        let name = "zubat"
        let networkServiceMock = NetworkServiceMock()
        networkServiceMock._dataTask = { _, completion in
            completion(.success(self.speciesByNameMockDataMock))
        }
        
        let apiService = PokemonAPIService(baseURL: url, network: networkServiceMock)
        apiService.speciesBy(name: name) { result in
            let data = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(data.name, "zubat")
            // TODO: check all properties
        }
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testApiDecodingTranslateText() {
        let expectation = self.expectation(description: "testApiDecodingTranslateText")
        
        let url = URL(string: "https://www.google.com")!
        let text = "text"
        let networkServiceMock = NetworkServiceMock()
        networkServiceMock._dataTask = { _, completion in
            completion(.success(self.translateTextDataMock))
        }
        
        let apiService = TranslationAPIService(baseURL: url, network: networkServiceMock)
        apiService.translate(text: text) { result in
            let data = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(data.contents.translation, "shakespeare")
            XCTAssertEqual(data.contents.translated, "Forms colonies in perpetually dark places. Uses ultrasonic waves to unfold and approach targets.")
            // TODO: check all properties
        }
        
        self.waitForExpectations(timeout: 1)
    }
}
