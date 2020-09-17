//
//  AppInfo.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/17/20.
//

import Foundation

public struct AppInfo {
    
    public static var bundleID: String {
        return Bundle.main.bundleIdentifier!
    }
    
    public static var version: String {
        return Bundle.main.shortBundleVersion
    }
    
    public static var buildNumber: String {
        return Bundle.main.bundleVersion
    }
    
    public static var versionWithBuildNumber: String {
        return "\(version) (\(buildNumber))"
    }
    
    public static var appName: String {
        return Bundle.main.name
    }
    
}

extension Bundle {
    
    var name: String {
        return stringValue(forKey: kCFBundleNameKey)!
    }
    
    var shortBundleVersion: String {
        return stringValue(forKey: "CFBundleShortVersionString")!
    }
    
    var bundleVersion: String {
        return stringValue(forKey: kCFBundleVersionKey as String)!
    }
    
}

// MARK: - Private
private extension Bundle {
    
    func stringValue(forKey key: String) -> String? {
        return object(forInfoDictionaryKey: key) as? String
    }
    
    func stringValue(forKey key: CFString) -> String? {
        return stringValue(forKey: key as String)
    }
    
}
