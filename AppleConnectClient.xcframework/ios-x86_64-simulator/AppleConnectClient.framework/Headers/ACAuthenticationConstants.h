//
//  ACAuthenticationConstants.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ACEnvironment)
{
    kACEnvironmentProduction,
    kACEnvironmentUAT,
    kACEnvironmentCompact
};

typedef NS_ENUM(NSInteger, ACError)
{
    /**
     Environment you specified in request does not exist.
     */
    kACErrorInvalidEnvironment = -2,
    /**
     User name you specified in request is invalid.
     */
    kACErrorInvalidUserName = -3,
    /**
     App ID is missing in request or invalid.
     */
    kACErrorInvalidAppID = -4,
    /**
     Context instance is not recognized.
     */
    kACErrorInvalidContextClass = -5,
    /**
     Request instance is not recognized.
     */
    kACErrorInvalidRequestClass = -6,
    /**
     Request to perform verify service ticket does not specify userName.
     */
    kACErrorUserNameIsMissing = -7,
    /**
     Service ticket is in verify service ticket request or invalid.
     */
    kACErrorInvalidServiceTicket = -8,
    /**
     AppleConnect context is unable to load AppleConnect Extension.
     
     Usually this error is handled by AppleConnectClient framework. If your application receives this error, it means that something wrong with application binary.
     This error is not possible if you have your application signed and submitted to Switchboard.
     */
    kACErrorFailedToLoadAppleConnect = -9, // __OSX_UNAVAILABLE
    /**
     ACAuthenticationContext is busy processing your previous request. Please make sure you received response from ACAuthenticationContext instance before you invoke its asynchronous methods again.
     */
    kACErrorContextIsBusy = -10,
    kACErrorInvalidServiceHost = -11, // __IOS_UNAVAILABLE
    
    kACErrorInvalidParameter = -12, // __IOS_UNAVAILABLE
    kACErrorInvalidSAMLRequest = -13, // __IOS_UNAVAILABLE
    /**
     User cancelled authentication process, which is possible only if your request cancellable authentication in request.
     */
    kACErrorCancelled = -100,
    /**
     Service ticket verification is failed. Please refer to underlying error for more details.
     */
    kACErrorServiceTicketVerificationFailed = -102,
    kACErrorFeatureNotFound = -105,
    kACErrorAppleConnectNotFound = -106, // __IOS_UNAVAILABLE
    /**
     Request is failed. Please refer to underlying error for more details. If AppleConnect context returned this error to your application, please contact AppleConnect Dev Team: AppleConnect_2_Dev_Team@group.apple.com
     */
    kACErrorOther = -99999,
};

/**
AppleConnect supports multiple authentication types, these are properties providing a hint to AppleConnect on which type of authentication is requested.
*/
typedef NS_ENUM(NSInteger, ACAuthenticationType)
{
    /**
     Returns ACMToken or Kerboros Token in `serviceTicket` property of `ACAuthenticationResponse` on successful authentication
     */
    kACAuthenticationTypeDefault = 0,
    /**
     Returns DAW Token in `serviceTicket` property of `ACAuthenticationResponse` on successful authentication
     */
    kACAuthenticationTypeDAW,
    /**
     Returns SAMLToken in `serviceTicket` property of `ACAuthenticationResponse` on successful authentication
     */
    kACAuthenticationTypeSAML // __IOS_UNAVAILABLE
};

/**
 AppleConnect supports multiple interactivity types, these are properties providing a hint to AppleConnect on how to handle the specific authentication attempt
 */
typedef NS_ENUM(NSInteger, ACInteractivityType)
{
    /**
     This option allows you to use the benefits of Sigle Sign On. AppleConnect will try to authenticate silently and if that fails, it will fallback to interactive (asking for password). This is the default value and everyone is recommended to use this for better User Experience.
     */
    ACInteractivityTypeSilentPreferred = 0,
    /**
     AppleConnect will attempt silent authentication without a fallback. This isn't available in iOS and Mac Cataylst.
     */
    ACInteractivityTypeSilent, // __IOS_UNAVAILABLE
    /**
     AppleConnect will force an interactive authentication, unless you provide a password upfront on the context. This will return an error if password is wrong.
     */
    ACInteractivityTypeInteractive
};

typedef NS_ENUM(NSInteger, ACAuthorizationBinding) {
    kACAuthorizationBindingQRCode = 0
};

#define kAppleConnectErrorDomain @"AppleConnectErrorDomain"

#if TARGET_OS_OSX
    #define kACUserDidSignInDistributedNotification @"com.apple.ist.ds.appleconnect.distributed.userDidSignIn"
    #define kACUserDidSignOutDistributedNotification @"com.apple.ist.ds.appleconnect.distributed.userDidSignOut"

    #define kACNotificationUserNameKey @"userName"
    #define kACNotificationEnvironmentKey @"environment"
    #define kACNotificationUserDidLogoutKey @"isUserLogout"
#endif
