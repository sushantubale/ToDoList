//
//  DeviceInfo.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/17/20.
//

import Foundation

#if os(macOS)
    import Cocoa
    import IOKit
#else
    import UIKit
#endif

public class DeviceInfo {
    
    public static let shared = DeviceInfo()
    public var isTrustedDevice = false
    
    public var udid: String {
        #if os(macOS)
            let deviceID = macDeviceUDID()
        #else
            let deviceID = iosDeviceIDFromMDM()
        #endif
        
        if let deviceID = deviceID {
            return deviceID
        } else {
            // This is a fallback that should typically not happen
            return customDeviceID()
        }
    }
    
    public let name: String = {
        #if os(macOS)
            return Host.current().localizedName ?? ""
        #else
            return UIDevice.current.name
        #endif
    }()
    
    public var type: String {
        #if os(macOS)
            return "Mac"
        #else
            return UI_USER_INTERFACE_IDIOM() == .phone ? "iPhone" : "iPad"
        #endif
    }
    
    public var osVersion: String {
        #if os(macOS)
            let version = ProcessInfo.processInfo.operatingSystemVersion
            return "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
        #else
            return UIDevice.current.systemVersion
        #endif
    }
    
    #if os(macOS)
    public var serialNumber: String? {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice") )
        
        guard platformExpert > 0 else {
            return nil
        }
        
        guard let serialNumber = (IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0).takeUnretainedValue() as? String) else {
            return nil
        }
        
        IOObjectRelease(platformExpert)
        return serialNumber
    }
    #endif
    
}

// MARK: Private
private extension DeviceInfo {

    #if os(macOS)
    func macDeviceUDID() -> String? {
        let platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"))
        
        defer { IOObjectRelease(platformExpert) }
        
        let serialNumberRef = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformUUIDKey as CFString, kCFAllocatorDefault, 0)
    
        return serialNumberRef?.takeUnretainedValue() as? String
    }
    #endif
    
    func iosDeviceIDFromMDM() -> String? {
        let configuration = UserDefaults.standard.object(forKey: "com.apple.configuration.managed") as? NSDictionary
        return configuration?.object(forKey: "udid") as? String
    }
    
    func customDeviceID() -> String {
        let key = "MSDeviceUDID"
        
        if let deviceID = UserDefaults.standard.string(forKey: key) {
            return deviceID
        } else {
            let deviceID = NSUUID().uuidString
            UserDefaults.standard.set(deviceID, forKey: key)
            return deviceID
        }
    }
    
}
