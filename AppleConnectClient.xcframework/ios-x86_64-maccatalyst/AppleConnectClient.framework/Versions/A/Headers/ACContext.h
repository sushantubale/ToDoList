//
//  ACContext.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACContextMessages.h>
#import <AppleConnectClient/AppleConnectClientDefines.h>

typedef void(^ACFetchVersionCompletion)(NSString * _Nullable version, NSError * _Nullable error);

AC_EXPORT
@interface ACContext : NSObject

@property (strong, readonly) NSString * _Nonnull version __OSX_UNAVAILABLE DEPRECATED_MSG_ATTRIBUTE("Use -fetchVersion:withCompletion: instead");
@property (assign, readonly) BOOL isBusy;

- (void)fetchVersion:(ACVersionType)type withCompletion:(nonnull ACFetchVersionCompletion)completion;

@end

