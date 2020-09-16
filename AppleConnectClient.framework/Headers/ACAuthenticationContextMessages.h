//
//  ACAuthenticationContextMessages.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 9/10/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACAuthenticationRequest : NSObject {
}
@property (retain) NSString * __nullable userName;
@property (assign) ACEnvironment environment;
@property (retain) NSNumber * __nonnull appID;
@property (assign) NSTimeInterval idleExpirationTimeout;
@property (assign) BOOL suppressSingleSignOn;
@property (assign) BOOL cancelable;

@end

@interface ACAuthenticationResponse : NSObject {
}
@property (retain) NSError * __nullable error;
@property (retain) NSString * __nullable userName;
@property (retain) NSString * __nullable serviceTicket;
@property (retain) NSNumber * __nullable personID;
@end

@interface ACVerifyServiceTicketRequest : NSObject {
}
@property (retain) NSString * __nonnull userName;
@property (assign) ACEnvironment environment;
@property (retain) NSNumber * __nonnull appID;
@property (retain) NSString * __nonnull serviceTicket;
@end

@interface ACVerifyServiceTicketResponse : NSObject {
}
@property (retain) NSError * __nullable error;
@property (retain) NSDictionary * __nullable responseInformation;
@end
