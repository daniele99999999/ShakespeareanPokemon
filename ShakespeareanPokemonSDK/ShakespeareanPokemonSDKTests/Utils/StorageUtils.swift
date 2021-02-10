//
//  StorageUtils.swift
//  ShakespeareanPokemonSDKTests
//
//  Created by daniele salvioni on 09/02/21.
//

import Foundation

struct StorageUtils
{
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> Array<Dictionary<String, Any>>?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        guard let JSONArray = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: Any]] else { return nil }
        return JSONArray
    }
    
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> Dictionary<String, Any>?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        guard let JSONDictionary = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else { return nil }
        return JSONDictionary
    }
    
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> Data?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        return data
    }
    
    static func loadJSON(name: String, bundle: Bundle = Bundle.main) -> String?
    {
        guard let path = bundle.url(forResource: name, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: path) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
