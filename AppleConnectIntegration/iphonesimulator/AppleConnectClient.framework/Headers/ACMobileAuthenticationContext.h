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
};

@interface ACMobileAuthenticationContext : ACAuthenticationContext
- (id __nonnull)initWithHostViewController: (UIViewController * __nonnull)controller;
@property (assign, nonatomic) BOOL suppressProgressIndicator; // if YES, ACMI will suppress showing progress if it cannot provide SSO ticket within 2 seconds.
@property (assign, nonatomic) BOOL coverApplicationDemandingProofOfPresence; // NO by default
@property (assign, nonatomic) BOOL useOpaqueInterface; // disables blurriness, interface is forced to be black or white in respect of uiStyle parameter, tintColor parameter is ignored.
@property (assign, nonatomic) ACMobileAuthenticationUIStyle uiStyle;
@property (retain, nonatomic) UIColor * __nullable tintColor; // tint color of the content
@end
