//
//  ACAuthenticationConstants.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 9/10/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ACEnvironment) {
    
    kACEnvironmentProduction,
    kACEnvironmentUAT
};

typedef NS_ENUM(NSInteger, ACLogLevel) {
    
    kACLogLevelOff,
    kACLogLevelErrors,
    kACLogLevelNotice,
    kACLogLevelProfile,
    kACLogLevelVerbose,
    kACLogLevelDetail,
    kACLogLevelCount
};

// kACErrorInvalidConfiguration: AppleConnect is not properly configured. Please refer AppleConnect API documentation.
// kACErrorInvalidEnvironment: Environment you specified in request does not exist.
// kACErrorInvalidUserName: User name you specified in request is invalid.
// kACErrorInvalidAppID: App ID is missing in request or invalid.
// kACErrorInvalidRequestClass: Request instance is not recognized.
// kACErrorUserNameIsMissing: Request to perform verify service ticket does not specify userName.
// kACErrorInvalidServiceTicket: Service ticket is in verify service ticket request or invalid.
// kACErrorFailedToLoadAppleConnect: AppleConnect context is unable to load AppleConnect Extension. Usually this error is handled by AppleConnectClient framework. If your application receives this error, it means that something wrong with application binary. This error is not possible if you have your application signed and submitted to Switchboard.
// kACErrorContextIsBusy: ACMobileAuthenticationContext is busy processing your previous request. Please make sure you received response from ACMobileAuthenticationContext instance before you invoke its asynchronous methods again.
// kACErrorCancelled: User cancelled authentication process, which is possible only if your request cancellable authentication in request.
// kACErrorAuthenticationFailed: Authentication is failed. Please refer to underlaying error for more details. Usually AppleConnect handles this error. If AppleConnect context returned this error to your application, please contact AppleConnect Dev Team: AppleConnect_2_Dev_Team@group.apple.com
// kACErrorServiceTicketVerificationFailed: Service ticket verification is failed. Please refer to underlaying error for more details.
// kACErrorNetworkFailure: Verify Service Ticket request is failed due to networking issue. Please refer to underlaying error for more details.
// kACErrorUserCredentialsAreExpired: Verify Service Ticket request is because user credentials are expired. You need receive new service ticket with authenticate: method.
// kACErrorInternal: Request is failed. Please refer to underlaying error for more details. If AppleConnect context returned this error to your application, please contact AppleConnect Dev Team: AppleConnect_2_Dev_Team@group.apple.com
typedef NS_ENUM(NSInteger, ACError) {
    
    kACErrorInvalidConfiguration = -1,
    kACErrorInvalidEnvironment = -2,
    kACErrorInvalidUserName = -3,
    kACErrorInvalidAppID = -4,
    kACErrorInvalidRequestClass = -6,
    kACErrorUserNameIsMissing = -7,
    kACErrorInvalidServiceTicket = -8,
    kACErrorFailedToLoadAppleConnect = -9,
    kACErrorContextIsBusy                   = -10,

    kACErrorCancelled = -100,
    kACErrorAuthenticationFailed = -101,
    kACErrorServiceTicketVerificationFailed = -102,
    kACErrorNetworkFailure = -103,
    kACErrorUserCredentialsAreExpired = -104,
    
    kACErrorInternal = -99999,
};

extern NSString * const kAppleConnectErrorDomain;
