//
//  ACMobileAuthenticationContext-Private.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 9/11/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppleConnectClient/ACMobileAuthenticationContext.h>

@protocol ACExtenstionProxyProtocol;

@interface ACMobileAuthenticationContext()
@property (nonatomic, assign) BOOL useWindowIfNeeded;
@property (nonatomic, assign) BOOL suppressFallbackScreens;
- (id __nonnull)initWithHostViewController:(UIViewController * __nullable)controller extensionProxy:(id<ACExtenstionProxyProtocol> __nonnull)extension;
- (void)signOutWithEnvironment: (ACEnvironment)environment completion: (void (^ __nonnull)())completion;
@end
