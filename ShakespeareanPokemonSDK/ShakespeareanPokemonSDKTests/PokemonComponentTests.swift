//
//  PokemonComponentTests.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 10/02/21.
//

import XCTest
@testable import ShakespeareanPokemonSDK
import SnapshotTesting

class PokemonComponentTests: XCTestCase {

    let pokemonImageSquared = UIImage(named: "pic500x500", in: Bundle(for: PokemonComponentTests.self), compatibleWith: .none)
    let pokemonImageHorizontal = UIImage(named: "pic500x250", in: Bundle(for: PokemonComponentTests.self), compatibleWith: .none)
    let pokemonImageVertical = UIImage(named: "pic250x500", in: Bundle(for: PokemonComponentTests.self), compatibleWith: .none)
    let sampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non dolor neque. Nulla facilisi."
    let device1 = CGRect.init(origin: .zero, size: .init(width: 375, height: 667))
    let device2 = CGRect.init(origin: .zero, size: .init(width: 360, height: 780))
    let device3 = CGRect.init(origin: .zero, size: .init(width: 390, height: 884))
    let device4 = CGRect.init(origin: .zero, size: .init(width: 428, height: 926))
    
    func testPokemonComponentViewDevice1Squared() {
        
        let view = PokemonComponent.View()
        view.frame = self.device1
        view.spriteView.image = self.pokemonImageSquared
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device1Squared", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice1Horizontal() {
        
        let view = PokemonComponent.View()
        view.frame = self.device1
        view.spriteView.image = self.pokemonImageHorizontal
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device1Horizontal", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice1Vertical() {
        
        let view = PokemonComponent.View()
        view.frame = self.device1
        view.spriteView.image = self.pokemonImageVertical
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device1Vertical", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice2Squared() {
        
        let view = PokemonComponent.View()
        view.frame = self.device2
        view.spriteView.image = self.pokemonImageSquared
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device2Squared", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice2Horizontal() {
        
        let view = PokemonComponent.View()
        view.frame = self.device2
        view.spriteView.image = self.pokemonImageHorizontal
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device2Horizontal", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice2Vertical() {
        
        let view = PokemonComponent.View()
        view.frame = self.device2
        view.spriteView.image = self.pokemonImageVertical
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device2Vertical", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice3Squared() {
        
        let view = PokemonComponent.View()
        view.frame = self.device3
        view.spriteView.image = self.pokemonImageSquared
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device3Squared", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice3Horizontal() {
        
        let view = PokemonComponent.View()
        view.frame = self.device3
        view.spriteView.image = self.pokemonImageHorizontal
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device3Horizontal", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice3Vertical() {
        
        let view = PokemonComponent.View()
        view.frame = self.device3
        view.spriteView.image = self.pokemonImageVertical
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device3Vertical", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice4Squared() {
        
        let view = PokemonComponent.View()
        view.frame = self.device4
        view.spriteView.image = self.pokemonImageSquared
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device4Squared", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice4Horizontal() {
        
        let view = PokemonComponent.View()
        view.frame = self.device4
        view.spriteView.image = self.pokemonImageHorizontal
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device4Horizontal", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
    
    func testPokemonComponentViewDevice4Vertical() {
        
        let view = PokemonComponent.View()
        view.frame = self.device4
        view.spriteView.image = self.pokemonImageVertical
        view.textLabel.text = self.sampleText

        let result = verifySnapshot(matching: view, as: .image, named: "Device4Vertical", testName: "PokemonComponent.View")
        XCTAssertNil(result)
    }
}
