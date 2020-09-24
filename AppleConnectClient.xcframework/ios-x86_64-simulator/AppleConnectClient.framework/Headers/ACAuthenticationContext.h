//
//  ACAuthenticationContext.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACContext.h>
#import <AppleConnectClient/ACAuthenticationConstants.h>

@class ACAuthenticationRequest;
@class ACAuthenticationResponse;
@class ACVerifyServiceTicketRequest;
@class ACVerifyServiceTicketResponse;

typedef void(^ACAuthenticationCompletion)(ACAuthenticationResponse * _Nonnull response);
typedef void(^ACVerifyServiceTicketCompletion)(ACVerifyServiceTicketResponse * _Nonnull response);
typedef void(^ACFetchCurrentUserNameCompletion)(NSString * _Nullable userName, NSError * _Nullable error);
typedef void(^ACSuggestedUserNameCompletion)(NSString * _Nullable userName) __OSX_UNAVAILABLE  DEPRECATED_ATTRIBUTE;

AC_EXPORT @interface ACAuthenticationContext : ACContext

@property (strong) NSNumber * _Nonnull appID;
@property (assign) ACEnvironment environment;

#pragma mark -

- (void)authenticateWithRequest:(ACAuthenticationRequest * _Nonnull)request completion:(nonnull ACAuthenticationCompletion)completion;
- (void)verifyServiceTicketWithRequest:(ACVerifyServiceTicketRequest * _Nonnull)request completion:(nonnull ACVerifyServiceTicketCompletion)completion;
- (void)fetchCurrentUserNameWithCompletion:(nonnull ACFetchCurrentUserNameCompletion)completion;
@end

AC_EXPORT @interface ACAuthenticationContext(Deprecated)
- (BOOL)fetchCurrentUserNameWithEnvironment:(ACEnvironment)environment completion:(nonnull ACSuggestedUserNameCompletion)completion __OSX_UNAVAILABLE  DEPRECATED_MSG_ATTRIBUTE("Use -fetchCurrentUserNameWithCompletion: instead");
@end
