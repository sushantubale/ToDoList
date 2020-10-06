//
//  ACMobileRetailAuthenticationContext.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 1/13/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACMobileAuthenticationContext.h>

AC_EXPORT @interface ACMobileRetailAuthenticationContext : ACMobileAuthenticationContext
@property (nonatomic, strong) NSData * _Nullable applicationData;
@property (nonatomic, strong) NSString * _Nullable failoverRetrieveSaltAPIAddress;
@property (nonatomic, strong) NSString * _Nullable failoverAuthenticateAPIAddress;

////////////////////////////////////////////////////////////////////////////////
//
// THE FOLLOWING METHOD AFFECTS ALL APPLICATIONS ON USER'S DEVICE.
// PLEASE NEVER USE IT TO END APP SESSION, AS IT CAN MAKE INFLUENCE
// ON PERFORMANCE OF APPLE STORE EMPLOYEES. IF YOU HAVE ANY QUESTIONS
// PLEASE CONTANCT IDMS COCOA ENGINEERING TEAM:
// appleconnect-mobile-feedback@group.apple.com
//
////////////////////////////////////////////////////////////////////////////////
- (void)signOutWithCompletion:(nonnull void(^)(NSError * _Nullable error))completion __OSX_UNAVAILABLE;
- (void)signOutWithEnvironment:(ACEnvironment)environment completion:(nonnull void(^)(void))completion DEPRECATED_MSG_ATTRIBUTE("Use -signOutWithCompletion: instead") __OSX_UNAVAILABLE;

@end


AC_EXPORT @interface ACAuthenticationRequest (Retail)
@property (nonatomic, assign) BOOL enforceFailover;
@end

AC_EXPORT @interface ACAuthenticationResponse (Retail)
@property (strong) NSDictionary * _Nullable responseInformation;
@end
