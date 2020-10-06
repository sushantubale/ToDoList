//
//  ACMobileRetailAuthenticationContext.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 1/13/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACMobileAuthenticationContext.h>

@interface ACMobileRetailAuthenticationContext : ACMobileAuthenticationContext
@property (nonatomic, retain) NSData *applicationData;
@property (nonatomic, retain) NSString *failoverRetrieveSaltAPIAddress;
@property (nonatomic, retain) NSString *failoverAuthenticateAPIAddress;

////////////////////////////////////////////////////////////////////////////////
//
// THE FOLLOWING METHOD AFFECTS ALL APPLICATIONS ON USER'S DEVICE.
// PLEASE NEVER USE IT TO END APP SESSION, AS IT CAN MAKE INFLUENCE
// ON PERFORMANCE OF APPLE STORE EMPLOYEES. IF YOU HAVE ANY QUESTIONS
// PLEASE CONTANCT IDMS COCOA ENGINEERING TEAM:
// appleconnect-mobile-feedback@group.apple.com
//
////////////////////////////////////////////////////////////////////////////////
- (void)signOutWithEnvironment: (ACEnvironment)environment completion: (void (^)())completion;

@end


@interface ACAuthenticationRequest (Retail)
@property (nonatomic, assign) BOOL enforceFailover;
@end

@interface ACAuthenticationResponse (Retail)
@property (retain) NSDictionary * responseInformation;
@end
