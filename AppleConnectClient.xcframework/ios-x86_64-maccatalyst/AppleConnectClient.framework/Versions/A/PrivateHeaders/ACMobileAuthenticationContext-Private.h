//
//  ACMobileAuthenticationContext-Private.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 9/11/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AppleConnectClient/ACMobileAuthenticationContext.h>

@protocol ACClientTransportProtocol;
@interface ACMobileAuthenticationContext()
@property (nonatomic, assign) BOOL useWindowIfNeeded;
@property (nonatomic, assign) BOOL suppressFallbackScreens;
- (void)signOutWithCompletion:(nonnull void(^)(NSError * _Nullable error))completion;
- (void)signOutWithEnvironment:(ACEnvironment)environment completion:(nonnull void(^)(void))completion DEPRECATED_MSG_ATTRIBUTE("Use -signOutWithCompletion: instead");
@end

