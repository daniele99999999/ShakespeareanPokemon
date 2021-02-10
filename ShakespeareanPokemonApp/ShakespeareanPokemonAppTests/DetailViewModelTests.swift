//
//  DetailViewModelTests.swift
//  ShakespeareanPokemonAppTests
//
//  Created by daniele salvioni on 10/02/21.
//

import XCTest
@testable import ShakespeareanPokemonApp
@testable import ShakespeareanPokemonSDK
@testable import ShakespeareanPokemonSDKTests

class DetailViewModelTests: XCTestCase {

    let pokemonDataMock: (name: String, url: URL, text: String) = (
        name: "name",
        url: URL(string: "https://www.google.com")!,
        text: "text"
    )
    
    func testScreenTitle() {
        let bookmarkServiceMock = BookmarkServiceMock()
        let detailViewModel = DetailViewModel(pokemonData: self.pokemonDataMock,
                                              bookmarkService: bookmarkServiceMock)
        
        let expectation = self.expectation(description: "testScreenTitle")
        
        detailViewModel.output.screenTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, self.pokemonDataMock.name)
        }
        
        detailViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testIsBookmarked() {
        let expectation1 = self.expectation(description: "testIsBookmarked1")
        let bookmarkServiceMock = BookmarkServiceMock()
        bookmarkServiceMock.list = [self.pokemonDataMock.name: true]
        
        let detailViewModel = DetailViewModel(pokemonData: self.pokemonDataMock,
                                              bookmarkService: bookmarkServiceMock)
        
        detailViewModel.output.isBookmarked = { value in
            expectation1.fulfill()
            XCTAssertTrue(value)
        }
        detailViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
        let expectation2 = self.expectation(description: "testIsBookmarked2")
        
        bookmarkServiceMock.list = [:]
        
        detailViewModel.output.isBookmarked = { value in
            expectation2.fulfill()
            XCTAssertFalse(value)
        }
        detailViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testBookmarkHint() {
        let expectation1 = self.expectation(description: "testBookmarkHint1")
        let bookmarkServiceMock = BookmarkServiceMock()
        bookmarkServiceMock.list = [self.pokemonDataMock.name: true]
        
        let detailViewModel = DetailViewModel(pokemonData: self.pokemonDataMock,
                                              bookmarkService: bookmarkServiceMock)
        
        detailViewModel.output.bookmarkHint = { value in
            expectation1.fulfill()
            XCTAssertEqual(value, NSLocalizedString("Detail.pokemon.Bookmark.on", comment: ""))
        }
        detailViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
        let expectation2 = self.expectation(description: "testBookmarkHint2")
        
        bookmarkServiceMock.list = [:]
        
        detailViewModel.output.bookmarkHint = { value in
            expectation2.fulfill()
            XCTAssertEqual(value, NSLocalizedString("Detail.pokemon.Bookmark.off", comment: ""))
        }
        detailViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testPokemonData() {
        let bookmarkServiceMock = BookmarkServiceMock()
        let detailViewModel = DetailViewModel(pokemonData: self.pokemonDataMock,
                                              bookmarkService: bookmarkServiceMock)
        
        let expectation = self.expectation(description: "testPokemonData")
        
        detailViewModel.output.pokemonData = { data in
            expectation.fulfill()
            XCTAssertEqual(data.name, self.pokemonDataMock.name)
            XCTAssertEqual(data.text, self.pokemonDataMock.text)
            XCTAssertEqual(data.url, self.pokemonDataMock.url)
        }
        
        detailViewModel.input.ready()
        
        self.waitForExpectations(timeout: 1)
    }
}
