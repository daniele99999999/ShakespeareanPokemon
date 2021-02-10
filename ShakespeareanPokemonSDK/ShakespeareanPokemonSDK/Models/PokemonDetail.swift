//
//  PokemonDetail.swift
//  ShakespeareanPokemonSDK
//
//  Created by daniele salvioni on 06/02/21.
//

import Foundation

public struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let sprites: Sprite
}

public extension PokemonDetail {
    struct Sprite: Codable, Equatable {
        let frontDefault: URL
        let frontShiny: URL?
        let backDefault: URL?
        let backShiny: URL?
        let officialArtwork: URL?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case backDefault = "back_default"
            case backShiny = "back_shiny"
            case other
        }
        
        enum OtherCodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
        
        enum OfficialArtworkCodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
        
        public init(frontDefault: URL,
                    frontShiny: URL? = nil,
                    backDefault: URL? = nil,
                    backShiny: URL? = nil,
                    officialArtwork: URL? = nil) {
            self.frontDefault = frontDefault
            self.frontShiny = frontShiny
            self.backDefault = backDefault
            self.backShiny = backShiny
            self.officialArtwork = officialArtwork
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.frontDefault = try container.decode(URL.self, forKey: .frontDefault)
            self.frontShiny = try container.decodeIfPresent(URL.self, forKey: .frontShiny)
            self.backDefault = try container.decodeIfPresent(URL.self, forKey: .backDefault)
            self.backShiny = try container.decodeIfPresent(URL.self, forKey: .backShiny)

            let otherContainer = try container.nestedContainer(keyedBy: OtherCodingKeys.self, forKey: .other)
            let officialArtworkContainer = try otherContainer.nestedContainer(keyedBy: OfficialArtworkCodingKeys.self, forKey: .officialArtwork)
            self.officialArtwork = try officialArtworkContainer.decodeIfPresent(URL.self, forKey: .frontDefault)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.frontDefault, forKey: .frontDefault)
            try container.encode(self.frontShiny, forKey: .frontShiny)
            try container.encode(self.backDefault, forKey: .backDefault)
            try container.encode(self.backShiny, forKey: .backShiny)

            var otherContainer = container.nestedContainer(keyedBy: OtherCodingKeys.self, forKey: .other)
            var officialArtworkContainer = otherContainer.nestedContainer(keyedBy: OfficialArtworkCodingKeys.self, forKey: .officialArtwork)
            try officialArtworkContainer.encodeIfPresent(self.officialArtwork, forKey: .frontDefault)
        }
    }
}

extension PokemonDetail: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}


public extension PokemonDetail.Sprite {
    var allSprites: [URL] {
        let urls: [URL?] = [self.officialArtwork,
                            self.frontDefault,
                            self.frontShiny,
                            self.backDefault,
                            self.backShiny]
        return urls.compactMap { $0 }
    }
    
    var iconSprite: URL {
        return self.frontDefault
    }
    
    var mainSprite: URL {
        return self.allSprites.first ?? self.iconSprite
    }
}
