//
//  ACNetworkingConstants.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kACNetworkStateDidChangeDistributedNotification @"com.apple.ist.ds.appleconnect.distributed.NetworkStateDidChange"

// contains BOOL value that indicates weather AC connected to Apple internal network or not
#define kACNotificationNetworkStateKey @"NetworkState"

// contains string value that indicates the type of connection
#define kACNotificationNetworkTypeKey @"NetworkType"

// contains string value that indicates the connection status (Will be present in notification if network type is VPN or Secure Wifi)
#define kACNotificationNetworkStatusKey @"NetworkStatus"

// network connection types
#define kACNotificationOfflineNetworkStateKey @"Offline"
#define kACNotificationPublicNetworkStateKey @"Public"
#define kACNotificationEthernetNetworkStateKey @"Ethernet"
#define kACNotificationVPNNetworkStateKey @"VPN"
#define kACNotificationSecureWiFiNetworkTypeKey @"SecureWiFi"

// network connection status
#define kACNotificationConnectedNetworkStatusKey @"Connected"
#define kACNotificationConnectingNetworkStatusKey @"Connecting"
#define kACNotificationDisconnectingNetworkStatusKey @"Disconnecting"
