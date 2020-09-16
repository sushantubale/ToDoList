//
//  ACAuthenticationContext.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 9/10/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppleConnectClient/ACAuthenticationConstants.h>
#import <AppleConnectClient/ACAuthenticationContextMessages.h>

@class ACAuthenticationRequest;
@class ACAuthenticationResponse;
@class ACVerifyServiceTicketRequest;
@class ACVerifyServiceTicketResponse;

typedef void (^ ACAuthenticationCompletion) (ACAuthenticationResponse * __nonnull response);
typedef void (^ ACSuggestedUserNameCompletion) (NSString * __nullable userName);
typedef void (^ ACVerifyServiceTicketCompletion) (ACVerifyServiceTicketResponse * __nonnull response);

@interface ACAuthenticationContext : NSObject {
}
@property (readonly, nonatomic) NSString * __nullable version;
@property (readonly, nonatomic) BOOL isBusy;
- (void) authenticateWithRequest: (ACAuthenticationRequest * __nonnull)request completion: (ACAuthenticationCompletion __nonnull)completion;
- (BOOL) fetchCurrentUserNameWithEnvironment: (ACEnvironment)environment completion: (ACSuggestedUserNameCompletion __nonnull)completion;
- (void) verifyServiceTicketWithRequest: (ACVerifyServiceTicketRequest * __nonnull)aRequest completion: (ACVerifyServiceTicketCompletion __nonnull)completion;
@end

