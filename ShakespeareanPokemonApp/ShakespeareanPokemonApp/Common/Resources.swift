//
//  Resources.swift
//  ShakespeareanPokemonApp
//
//  Created by daniele salvioni on 06/02/21.
//

import UIKit

enum Resources {
    enum Interface {
        static let main = "Main"
    }
    enum AppInfo {
        static var appVersion: String {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        }
        
        static var appBuildVersion: String {
            return (Bundle.main.object(forInfoDictionaryKey: (kCFBundleVersionKey as String?) ?? "")) as? String ?? ""
        }
        
        static var appBundleName: String {
            return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        }
        
        static var appDisplayName: String {
            return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? Resources.AppInfo.appBundleName
        }
        
        static var appExecutableName: String {
            return Bundle.main.infoDictionary?["CFBundleExecutable"] as? String ?? ""
        }
        
        static var appProcessName: String {
            return ProcessInfo.processInfo.processName
        }
        
        static var appFileName: String {
            let bundlePath: String = Bundle.main.bundlePath
            return FileManager.default.displayName(atPath: bundlePath)
        }
        
        static var appBundleIdentifier: String {
            return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
        }
    }
}

