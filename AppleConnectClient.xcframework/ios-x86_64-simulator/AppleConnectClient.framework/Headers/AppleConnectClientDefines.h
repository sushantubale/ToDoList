//
//	AppleConnectClientDefines.h
//	AppleConnectClient
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#ifndef	__APPLE_CONNECT_CLIENT_DEFINES_H__
#define	__APPLE_CONNECT_CLIENT_DEFINES_H__

#ifndef AC_EXPORT
#define AC_EXPORT __attribute__((visibility("default")))
#endif

#ifndef AC_CLIENT_EXPORT
#define AC_CLIENT_EXPORT AC_EXPORT
#endif

#endif
