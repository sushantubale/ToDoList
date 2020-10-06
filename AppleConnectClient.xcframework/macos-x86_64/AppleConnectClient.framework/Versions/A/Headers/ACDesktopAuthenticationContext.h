//
//  ACDesktopAuthenticationContext.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACAuthenticationContext.h>

typedef void(^ACFetchSSOEnabledStateCompletion)(BOOL isSSOEnabled, NSError * _Nullable error);

AC_EXPORT @interface ACDesktopAuthenticationContext : ACAuthenticationContext
@property (strong) NSString * _Nullable serviceHost;

- (void)fetchSSOEnabledStateWithCompletion:(nonnull ACFetchSSOEnabledStateCompletion)completion;

@end
