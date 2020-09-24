//
//  ACMobileAuthenticationContext-Private.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 9/11/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//

#ifndef AC_IMPORT
    #define AC_IMPORT(X) <AppleConnectClient/X>
#endif

#import <UIKit/UIKit.h>
#import AC_IMPORT(ACMobileAuthenticationContext.h)

@interface ACMobileAuthenticationContext(EasyPayPrivate)
- (id _Nonnull)initWithHostViewController:(UIViewController * _Nonnull)controller modalPresentationStyle:(UIModalPresentationStyle)style;
@end
