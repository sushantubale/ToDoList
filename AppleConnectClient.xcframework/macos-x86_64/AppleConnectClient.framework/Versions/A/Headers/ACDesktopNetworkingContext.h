//
//  ACNetworkingContext.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACContext.h>
#import <AppleConnectClient/ACNetworkingConstants.h>

@class ACNetworkStatus;
typedef void(^ACFetchNetworkStatusCompletion)(ACNetworkStatus * _Nullable status, NSError * _Nullable error);

AC_EXPORT @interface ACDesktopNetworkingContext : ACContext

- (void)fetchStatusWithCompletion:(nonnull ACFetchNetworkStatusCompletion)completion;

- (void)connectWithCompletion:(nullable void(^)(NSError * _Nullable error))completion;
- (void)disconnectWithCompletion:(nullable void(^)(NSError * _Nullable error))completion;

@end


AC_EXPORT @interface ACNetworkStatus : NSObject

@property (strong, readonly, nonnull) NSString *networkType;
@property (assign, readonly) BOOL isConnected;
@property (assign, readonly) BOOL isConfigured;

@end
