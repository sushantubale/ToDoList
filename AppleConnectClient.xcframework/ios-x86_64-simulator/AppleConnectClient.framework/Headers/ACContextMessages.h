//
//  ACContextMessages.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import AC_IMPORT(AppleConnectClientDefines.h)

typedef NS_ENUM(NSUInteger, ACVersionType)
{
    ACVersionTypeFull = 0,
    ACVersionTypeShort,
    ACVersionTypeBundle
};

AC_CLIENT_EXPORT
@interface ACRequest : NSObject
@end

AC_CLIENT_EXPORT
@interface ACResponse : NSObject
@property (strong) NSError * _Nullable error;
@end
