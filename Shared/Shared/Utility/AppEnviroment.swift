//
//  AppEnviroment.swift
//  ToDoList (iOS)
//
//  Created by Sushant-Old on 9/16/20.
//

import Foundation

public struct AppEnvironment {
    
    // MARK: Public Properties
    public enum EnvironmentType: String {
        case DEV, PROD, QA, UAT
    }
    
    public static let environmentType: EnvironmentType = {
        switch AppInfo.bundleID.uppercased() {
        case let x where x.hasSuffix("DEV"):    return .DEV
        case let x where x.hasSuffix("QA"):     return .QA
        case let x where x.hasSuffix("UAT"):    return .UAT
        default:                                return .PROD
        }
    }()
    
    public static let appID: NSNumber = 4325
    
    public static var defaultNetworkEnvironment: NetworkEnvironment = {
        var env = NetworkEnvironment(environmentType.rawValue, host: serverURL)
        env.headers = ["Accept-Encoding": "gzip,deflate",
                       "Accept": "*/*",
                       "Content-Type": "application/json",
                       "CLIENT_VERSION": version,
                       "APP_DISPLAY_NAME": AppInfo.appName,
                       "DEVICE_NAME": DeviceInfo.shared.name,
                       "DEVICE_TYPE": DeviceInfo.shared.type,
                       "UDID": DeviceInfo.shared.udid,
                       "OS_VERSION": DeviceInfo.shared.osVersion,
                       "BUNDLE_ID": AppInfo.bundleID]
        return env
    }()
    
    public static var krakatauNetworkEnvironment: NetworkEnvironment = {
        var env = NetworkEnvironment(environmentType.rawValue, host: krakatauServerURL)
        env.headers = ["Content-Type": "application/json"]
        return env
    }()
    
    public static var avatarNetworkEnvironment: NetworkEnvironment = {
        var env = NetworkEnvironment(environmentType.rawValue, host: avatarServerURL)
        return env
    }()
    
    public static var splunkNetworkEnvironment: NetworkEnvironment = {
        var env = NetworkEnvironment(environmentType.rawValue, host: splunkServerURL)
        env.headers = ["Content-Type": "application/json"]
        return env
    }()
    
    public static var isPROD: Bool {
        return environmentType == .PROD
    }
    
    public static var serverURL: String {
        switch environmentType {
        case .DEV:  return "https://heisenberg-dev.corp.apple.com/public"
        case .PROD: return "https://mobileproxy.apple.com/proxy/heisenberg"
        case .QA:   return "https://rn2-mysecurityqa-ci.rno.apple.com/public"
        case .UAT:  return "https://mobileproxy-uat.apple.com:443/proxy/heisenberg-uat"
        }
    }
    
    public static var krakatauServerURL: String {
        switch environmentType {
        case .DEV:  return "https://krakatau-uat.apple.com"
        case .PROD: return "https://krakatau.apple.com"
        case .QA:   return "https://krakatau-uat.apple.com"
        case .UAT:  return "https://krakatau-uat.apple.com"
        }
    }
    
    public static var avatarServerURL: String {
        return "https://avatars.apple.com"
    }
    
    public static var splunkAuthorizationKey: String {
        switch environmentType {
        case .PROD:
            return "2CD3E50D-BEB3-4F73-BA10-5E846CE94812"
        case .DEV, .QA, .UAT:
            return "34E0EBE6-8BF9-4CEC-B325-19FC0A5C7BEC"
        }
    }
    
    public static var switchboardURLScheme: String {
        switch environmentType {
        case .DEV:  return "swbd-dev"
        case .PROD: return "swbd"
        case .QA:   return "swbd-qa"
        case .UAT:  return "swbd"
        }
    }
    
    public static var switchboardAppURL: URL? {
        #if os(macOS)
        return nil
        #else
        return URL(string: "\(AppEnvironment.switchboardURLScheme)://\(AppInfo.bundleID)")
        #endif
    }
    
    public static var version: String {
        return AppInfo.version
    }
    
    // MARK: Private Properties
    private static var splunkServerURL: String {
        switch environmentType {
        case .DEV:  return "https://splunk-hec-uat.corp.apple.com"
        case .PROD: return "https://splunk-hec.corp.apple.com"
        case .QA:   return "https://splunk-hec-uat.corp.apple.com"
        case .UAT:  return "https://splunk-hec-uat.corp.apple.com"
        }
    }
    
}
