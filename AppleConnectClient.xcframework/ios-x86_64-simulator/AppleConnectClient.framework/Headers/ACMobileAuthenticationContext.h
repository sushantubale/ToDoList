//
//  ACMobileAuthenticationContext.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 9/11/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppleConnectClient/ACAuthenticationContext.h>

typedef NS_ENUM(NSUInteger, ACMobileAuthenticationUIStyle) {
    kACMobileAuthenticationUIStyleInherit = 0, // default behavior
    kACMobileAuthenticationUIStyleLight = 1, // force set ACMI UI style to be light colored (with black text color)
    kACMobileAuthenticationUIStyleDark = 2 // force set ACMI UI style to be dark colored (with white text color)
} NS_DEPRECATED_IOS(12.0, 13.0, "Configure your app's UIUserInterfaceStyle instead.");

AC_EXPORT @interface ACMobileAuthenticationContext : ACAuthenticationContext
- (id _Nonnull)initWithHostViewController:(UIViewController * _Nonnull)controller;
@property (assign, nonatomic) BOOL suppressProgressIndicator; // if YES, ACMI will suppress showing progress if it cannot provide SSO ticket within 2 seconds.
@property (assign, nonatomic) BOOL coverApplicationDemandingProofOfPresence; // NO by default
@property (assign, nonatomic) BOOL useOpaqueInterface; // disables blurriness, interface is forced to be black or white in respect of uiStyle parameter, tintColor parameter is ignored.
@property (assign, nonatomic) ACMobileAuthenticationUIStyle uiStyle NS_DEPRECATED_IOS(12.0, 13.0, "Configure your app's UIUserInterfaceStyle instead.");
@property (retain, nonatomic) UIColor * _Nullable tintColor; // tint color of the content
@end

