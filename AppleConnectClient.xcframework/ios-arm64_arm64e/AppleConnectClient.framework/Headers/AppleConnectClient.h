//
//	AppleConnectClient.h
//	AppleConnectClient
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#ifndef	__APPLE_CONNECT_CLIENT_H__
#define	__APPLE_CONNECT_CLIENT_H__

#ifndef AC_IMPORT
    #define AC_IMPORT(X) <AppleConnectClient/X>
#endif

#ifdef  __OBJC__
    #import <Foundation/Foundation.h>
#endif

#import <AppleConnectClient/AppleConnectClientDefines.h>

#if TARGET_OS_OSX
    #ifdef	__OBJC__
        #import <AppleConnectClient/ACAuthenticationConstants.h>
        #import <AppleConnectClient/ACAuthenticationContext.h>
        #import <AppleConnectClient/ACAuthenticationContextMessages.h>
        #import <AppleConnectClient/ACContext.h>
        #import <AppleConnectClient/ACContextMessages.h>
        #import <AppleConnectClient/ACDesktopAuthenticationContext.h>
        #import <AppleConnectClient/ACDesktopNetworkingContext.h>
        #import <AppleConnectClient/AppleConnectClientProtocol.h>
        #import <AppleConnectClient/AppleConnectClientMessages.h>
        #import <AppleConnectClient/AppleConnectClientConstants.h>
        #import <AppleConnectClient/ACNetworkingConstants.h>
    #endif
    #include <AppleConnectClient/AppleConnectClientLegacy.h>
#elif TARGET_OS_TV
    #import <AppleConnectClient/ACAuthenticationContextMessages.h>
//    #import <AppleConnectClient/ACIdentityProviderProtocol.h>
//    #import <AppleConnectClient/ACContactlessAuthorizationContext.h>
//    #import <AppleConnectClient/ACContactlessAuthorizationClientContext.h>
#else
    #import <Foundation/Foundation.h>
    #import <AppleConnectClient/ACAuthenticationContextMessages.h>
    #import <AppleConnectClient/ACMobileAuthenticationContext.h>
    #import <AppleConnectClient/ACMobileRetailAuthenticationContext.h>
    #import <AppleConnectClient/ACMobileRetailManagerAuthenticationContext.h>
#if !TARGET_OS_UIKITFORMAC
//    #import <AppleConnectClient/ACIdentityProviderProtocol.h>
//    #import <AppleConnectClient/ACContactlessAuthorizationContext.h>
//    #import <AppleConnectClient/ACContactlessAuthorizationProviderContext.h>
#endif
    // Backward compatibility: declaration of the deprecated interface
    #import <AppleConnectClient/ACAuthenticationContextMessagesLegacy.h>
#endif

#endif
