//
//  SearchViewModelTests.swift
//  ShakespeareanPokemonAppTests
//
//  Created by daniele salvioni on 10/02/21.
//

import XCTest
@testable import ShakespeareanPokemonApp
@testable import ShakespeareanPokemonSDK
@testable import ShakespeareanPokemonSDKTests

class SearchViewModelTests: XCTestCase {

    let pokemonImageURL = URL(string: "https://www.google.com")!
    let pokemonShakespeareanDescription = "pokemonShakespeareanDescription"
    let pokemonNameToSearch = "zubat"
    
    func testScreenTitle() {
        let shakespeareanPokemonServiceMock = ShakespeareanPokemonServiceMock()
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.success(self.pokemonImageURL))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.success(self.pokemonShakespeareanDescription))
        }
        let searchViewModel = SearchViewModel(shakespeareanPokemonService: shakespeareanPokemonServiceMock)
        
        let expectation = self.expectation(description: "testScreenTitle")
        
        searchViewModel.output.screenTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, NSLocalizedString("Search.title", comment: ""))
        }
        
        searchViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testSearchInputPlaceholder() {
        let shakespeareanPokemonServiceMock = ShakespeareanPokemonServiceMock()
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.success(self.pokemonImageURL))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.success(self.pokemonShakespeareanDescription))
        }
        let searchViewModel = SearchViewModel(shakespeareanPokemonService: shakespeareanPokemonServiceMock)
        
        let expectation = self.expectation(description: "testSearchInputPlaceholder")
        
        searchViewModel.output.searchInputPlaceholder = { title in
            expectation.fulfill()
            XCTAssertEqual(title, NSLocalizedString("Search.textfield.placeholder", comment: ""))
        }
        
        searchViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testSearchButtonTitle() {
        let shakespeareanPokemonServiceMock = ShakespeareanPokemonServiceMock()
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.success(self.pokemonImageURL))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.success(self.pokemonShakespeareanDescription))
        }
        let searchViewModel = SearchViewModel(shakespeareanPokemonService: shakespeareanPokemonServiceMock)
        
        let expectation = self.expectation(description: "testSearchButtonTitle")
        
        searchViewModel.output.searchButtonTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, NSLocalizedString("Search.button.title", comment: ""))
        }
        
        searchViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsLoading() {
        let expectation1 = self.expectation(description: "testIsLoading1")
        expectation1.expectedFulfillmentCount = 5
        var loadingCount = 0
        
        let shakespeareanPokemonServiceMock = ShakespeareanPokemonServiceMock()
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.success(self.pokemonImageURL))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.success(self.pokemonShakespeareanDescription))
        }
        let searchViewModel = SearchViewModel(shakespeareanPokemonService: shakespeareanPokemonServiceMock)
        searchViewModel.output.isLoading = { isLoading in
            loadingCount += 1
            expectation1.fulfill()
        }
        searchViewModel.input.ready()
        searchViewModel.input.search(self.pokemonNameToSearch)
        
        self.waitForExpectations(timeout: 1)
        XCTAssertEqual(loadingCount, 5)
        
        let expectation2 = self.expectation(description: "testIsLoading2")
        expectation2.expectedFulfillmentCount = 3
        loadingCount = 0
        
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.failure(NetworkService.NetworkError.notFound))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.success(self.pokemonShakespeareanDescription))
        }
        
        searchViewModel.output.isLoading = { isLoading in
            loadingCount += 1
            expectation2.fulfill()
        }
        searchViewModel.input.ready()
        searchViewModel.input.search(self.pokemonNameToSearch)
        
        self.waitForExpectations(timeout: 1)
        XCTAssertEqual(loadingCount, 3)
        
        let expectation3 = self.expectation(description: "testIsLoading3")
        expectation3.expectedFulfillmentCount = 5
        loadingCount = 0
        
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.success(self.pokemonImageURL))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.failure(NetworkService.NetworkError.tooManyRequests))
        }
        
        searchViewModel.output.isLoading = { isLoading in
            loadingCount += 1
            expectation3.fulfill()
        }
        searchViewModel.input.ready()
        searchViewModel.input.search(self.pokemonNameToSearch)
        
        self.waitForExpectations(timeout: 1)
        XCTAssertEqual(loadingCount, 5)
    }
    
    func testError() {
        let expectation = self.expectation(description: "testError")
        
        let shakespeareanPokemonServiceMock = ShakespeareanPokemonServiceMock()
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.failure(NetworkService.NetworkError.notFound))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.failure(NetworkService.NetworkError.tooManyRequests))
        }
        let searchViewModel = SearchViewModel(shakespeareanPokemonService: shakespeareanPokemonServiceMock)
        searchViewModel.output.error = { data in
            expectation.fulfill()
            XCTAssertEqual(data.title, NSLocalizedString("Error.alert.title", comment: ""))
            XCTAssertEqual(data.message, NSLocalizedString("Error.pokemonAPI.notFound", comment: ""))
            XCTAssertEqual(data.confirmTitle, NSLocalizedString("Error.alert.button.ok", comment: ""))
        }
        searchViewModel.input.ready()
        searchViewModel.input.search(self.pokemonNameToSearch)
        
        self.waitForExpectations(timeout: 1)
        
        // TODO test all remaining errors
    }
    
    func testPokemonData() {
        let expectation = self.expectation(description: "testPokemonData")
        
        let shakespeareanPokemonServiceMock = ShakespeareanPokemonServiceMock()
        shakespeareanPokemonServiceMock._pokemonImage = { _, completion in
            completion(.success(self.pokemonImageURL))
        }
        shakespeareanPokemonServiceMock._pokemonShakespeareanDescription = { _, completion in
            completion(.success(self.pokemonShakespeareanDescription))
        }
        let searchViewModel = SearchViewModel(shakespeareanPokemonService: shakespeareanPokemonServiceMock)
        searchViewModel.output.pokemonData = { data in
            expectation.fulfill()
            XCTAssertEqual(data.name, self.pokemonNameToSearch)
            XCTAssertEqual(data.text, self.pokemonShakespeareanDescription)
            XCTAssertEqual(data.url, self.pokemonImageURL)
        }
        searchViewModel.input.ready()
        searchViewModel.input.search(self.pokemonNameToSearch)
        
        self.waitForExpectations(timeout: 1)
    }
}
