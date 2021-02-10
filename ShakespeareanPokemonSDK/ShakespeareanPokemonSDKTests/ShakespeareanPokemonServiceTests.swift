//
//  ShakespeareanPokemonServiceTests.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

import XCTest
@testable import ShakespeareanPokemonSDK

class ShakespeareanPokemonServiceTests: XCTestCase {

    let pokemonDetailMockWithOfficialArtwork = PokemonDetail.mockWithOfficialArtwork()
    let pokemonDetailMockWithoutOfficialArtwork = PokemonDetail.mockWithoutOfficialArtwork()
    let pokemonSpeciesMockWithFlavorText = PokemonSpecies.mockWithFlavorText()
    let pokemonSpeciesMockWithoutFlavorText = PokemonSpecies.mockWithoutFlavorText()
    let translationMock = Translation.mock()
    let pokemonName = "zubat"
    
    func testShakespeareanPokemonServicePokemonImage() {
        
        let pokemonAPIServiceMock = PokemonAPIServiceMock()
        pokemonAPIServiceMock._pokemonBy = { _, completion in
            completion(.success(self.pokemonDetailMockWithOfficialArtwork))
        }
        pokemonAPIServiceMock._speciesBy = { _, completion in
            completion(.success(self.pokemonSpeciesMockWithFlavorText))
        }
        let translationAPIServiceMock = TranslationAPIServiceMock()
        translationAPIServiceMock._translate = { _, completion in
            completion(.success(self.translationMock))
        }
        
        let apiService = ShakespeareanPokemonService(pokemonAPI: pokemonAPIServiceMock,
                                                     translationAPI: translationAPIServiceMock)
        
        let expectation1 = self.expectation(description: "testShakespeareanPokemonServicePokemonImage1")
        
        apiService.pokemonImage(name: self.pokemonName) { result in
            let dataOut = try! result.get()
            
            expectation1.fulfill()
            XCTAssertEqual(dataOut, self.pokemonDetailMockWithOfficialArtwork.sprites.officialArtwork!)
        }
        
        self.waitForExpectations(timeout: 1)
        let expectation2 = self.expectation(description: "testShakespeareanPokemonServicePokemonImage2")
        
        pokemonAPIServiceMock._pokemonBy = { _, completion in
            completion(.success(self.pokemonDetailMockWithoutOfficialArtwork))
        }
        
        apiService.pokemonImage(name: self.pokemonName) { result in
            let dataOut = try! result.get()
            
            expectation2.fulfill()
            XCTAssertEqual(dataOut, self.pokemonDetailMockWithOfficialArtwork.sprites.frontDefault)
        }
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testShakespeareanPokemonServicePokemonShakespeareanDescription() {
        
        let pokemonAPIServiceMock = PokemonAPIServiceMock()
        pokemonAPIServiceMock._pokemonBy = { _, completion in
            completion(.success(self.pokemonDetailMockWithOfficialArtwork))
        }
        pokemonAPIServiceMock._speciesBy = { _, completion in
            completion(.success(self.pokemonSpeciesMockWithFlavorText))
        }
        let translationAPIServiceMock = TranslationAPIServiceMock()
        translationAPIServiceMock._translate = { _, completion in
            completion(.success(self.translationMock))
        }
        
        let apiService = ShakespeareanPokemonService(pokemonAPI: pokemonAPIServiceMock,
                                                     translationAPI: translationAPIServiceMock)
        
        let expectation1 = self.expectation(description: "testShakespeareanPokemonServicePokemonShakespeareanDescription1")
        
        apiService.pokemonShakespeareanDescription(name: self.pokemonName) { result in
            let dataOut = try! result.get()

            expectation1.fulfill()
            XCTAssertEqual(dataOut, self.translationMock.contents.translated)
        }
        
        self.waitForExpectations(timeout: 1)
        let expectation2 = self.expectation(description: "testShakespeareanPokemonServicePokemonShakespeareanDescription2")
        
        pokemonAPIServiceMock._speciesBy = { _, completion in
            completion(.success(self.pokemonSpeciesMockWithoutFlavorText))
        }
        
        apiService.pokemonShakespeareanDescription(name: self.pokemonName) { result in
            let dataOut = try! result.get()

            expectation2.fulfill()
            XCTAssertEqual(dataOut, "")
        }
        
        self.waitForExpectations(timeout: 1)
    }
}
