//
//  ACMobileRetailManagerAuthenticationContext.h
//  AppleConnectFramework
//
//  Created by Volodymyr Prokurashko on 1/13/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

#import <AppleConnectClient/ACMobileRetailAuthenticationContext.h>

AC_EXPORT @interface ACMobileRetailManagerAuthenticationContext : ACMobileRetailAuthenticationContext
@property (nonatomic, strong) NSString *promptString;
@end
