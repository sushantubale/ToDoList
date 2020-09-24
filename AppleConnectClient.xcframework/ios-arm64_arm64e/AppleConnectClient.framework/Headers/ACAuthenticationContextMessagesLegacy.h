//
//  ACAuthenticationContextMessagesLegacy.h
//  AppleConnectClientMobile
//
//  Created by Mayur Tolani on 6/11/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACAuthenticationContextMessages.h>

@protocol ACRequestLegacyProtocol
@property (nonatomic, assign) ACEnvironment environment DEPRECATED_MSG_ATTRIBUTE("Use ACAuthenticationContext instead of ACAuthenticationRequest");
@property (nonatomic, strong) NSNumber * _Nonnull appID DEPRECATED_MSG_ATTRIBUTE("Use ACAuthenticationContext instead of ACAuthenticationRequest");
@end

@protocol ACVerifyServiceTicketLegacyProtocol
@property (nonatomic, assign) ACEnvironment environment DEPRECATED_MSG_ATTRIBUTE("Use ACAuthenticationContext instead of ACVerifyServiceTicketRequest");
@property (nonatomic, strong) NSNumber * _Nonnull appID DEPRECATED_MSG_ATTRIBUTE("Use ACAuthenticationContext instead of ACVerifyServiceTicketRequest");
@end

@interface ACAuthenticationRequest (ACAuthenticationContextMessagesLegacy) <ACRequestLegacyProtocol>

@end

@interface ACVerifyServiceTicketRequest (ACAuthenticationContextMessagesLegacy) <ACRequestLegacyProtocol>

@end
