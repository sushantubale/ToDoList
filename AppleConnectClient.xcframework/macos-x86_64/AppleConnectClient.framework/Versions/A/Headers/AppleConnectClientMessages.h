//
//  AppleConnectClientMessages.h
//  AppleConnectClient
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#ifndef	__APPLE_CONNECT_CLIENT_MESSAGES_H__
#define	__APPLE_CONNECT_CLIENT_MESSAGES_H__

#ifdef	__OBJC__
#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark Request / Response protocols

/*
 ===================
 ACAuthenticationRequest protocol
 ===================
 
 Provides methods to access required and optional parameters which are used in authentication request.
 
 Realm:
 This parameter is the environment in which authentication is requested. Indicates
 which Kerberos Realm the app is connecting to.
 This is mandatory parameter and can't be NULL.
 
 ServiceApplicationId:
 Service application credentials ID. Assigned to application on registration with DS.
 Usually a small number, like 229.
 This is mandatory parameter and can be NULL only if parameter “ServiceName“ is specified.
 Important note: Please, do not use Sample Application’s credentials for
 authenticating your application. Always use credentials assigned to
 your application upon registration with DS.
 
 ServiceName:
 This corresponds to the service id assigned to the application in the Kerberos
 KDC by Directory Services. This is a 17-digit number.
 This parameter is deprecated, will be removed with support for legacy API. Use parameter “ServiceApplicationId“ instead.
 Important note: Please, do not use Sample Application's credentials for
 authenticating your application. Always use credentials assigned to
 your application upon registration with DS.
 
 ServiceHost:
 This is the host on which service ticket is verified.
 This is optional parameter and can be NULL.
 
 UserName:
 This is the user name as which application wants to Sign In. This is optional
 parameter and can be passed as NULL, except in cases when application want to
 Sign In only a particular user like when application session expired. If the user
 name is not null then an attempt is made to fetch the service ticket for
 the provided user. In appropriate cases the SSO Login Window is popped up.
 
 ShouldIgnoreSSO:
 This is optional parameter. Default value is NO. If set to YES then user need to provide
 AppleConnect credentials to login to application, even if he is already signed in AppleConnect.
 */

@protocol ACAuthenticationRequest <NSObject>

// user must specify the following parameters
@property (strong) NSString * _Nonnull realm;
@property (strong) NSNumber * _Nullable serviceApplicationId;

// optional params
@property (strong) NSString * _Nullable serviceName DEPRECATED_MSG_ATTRIBUTE("Use 'serviceApplicationId' instead");
@property (strong) NSString * _Nullable serviceHost;
@property (strong) NSString * _Nullable userName;
@property (assign) BOOL shouldIgnoreSSO;

@property (strong) NSString * _Nullable serviceTicketPolicyId DEPRECATED_ATTRIBUTE;
@property (assign) BOOL shouldShowProgressWhileSignIn DEPRECATED_ATTRIBUTE;

@end

/*
 ===================
 ACAuthenticationResponse protocol
 ===================
 
 Provides methods to access data associated with response on authentication request.
 
 UserName:
 This is the user name for which the service ticket was received. This is passed
 to be used by applications in case required.
 
 Realm:
 This parameter is the environment in which authentication is requested. Indicates
 which Kerberos Realm the app is connecting to.
 
 ServiceTicketData:
 This is the service ticket(Kerberos terminology) that is specific to the application.
 
 ClientContext:
 This context is needed for post login purposes. Don't expect context to have any
 meaning to the client app, or be accessible from the context of the calling app.
 It will be used later.
 
 Error:
 This is the error message in case of any error occurred in the method call.
 */

@protocol ACAuthenticationResponse <NSObject>
@property (strong) NSString * _Nullable userName;
@property (strong) NSString * _Nullable realm;
@property (strong) NSData * _Nullable serviceTicketData;
@property (strong) NSValue * _Nullable clientContext;
@property (strong) NSError * _Nullable error;
@end

/*
 ===================
 ACPostLoginRequest protocol
 ===================
 
 Provides methods to access required and optional parameters which are used in post login request.
 
 MutualAuthenticationToken:
 This is the mutual authentication token obtained from the SSO server.
 This is optional parameter and can be NULL.
 
 ClientContext:
 This is the context obtained from the 'authenticate:' or 'authenticate:withPassword:' call.
 This is mandatory parameter and can't be NULL.
 
 isStealthMode:
 This is optional parameter. Default is 'NO'. Should be set to 'YES' for CLI or non-graphics mode.
 
 */

@protocol ACPostLoginRequest <NSObject>
@property (strong) NSData * _Nullable mutualAuthenticationToken;
@property (strong) NSValue * _Nonnull clientContext;
@property (assign) BOOL isStealthMode;
@end

/*
 ===================
 ACPostLoginResponse protocol
 ===================
 
 Provides methods to access data associated with response on post login request.
 
 Error:
 This is the error message in case of any error occurred in the method call.
 */

@protocol ACPostLoginResponse <NSObject>
@property (strong) NSError * _Nullable error;
@end

/*
 ===================
 ACVerifyServiceTicketRequest protocol
 ===================
 
 Provides methods to access parameters which are used in verify service ticket request.
 
 UserName:
 This is the user name associated with the ticket. This can't be NULL.
 
 Realm:
 This parameter is the environment in which authentication is requested. Indicates
 which Kerberos Realm the app is connecting to.
 This is mandatory parameter and can't be NULL.
 
 ServiceApplicationId:
 Service application credentials ID. Assigned to application on registration with DS.
 Usually a small number, like 229.
 This is mandatory parameter and can be NULL only if parameter “ServiceName“ is specified.
 Important note: Please, do not use Sample Application’s credentials for
 authenticating your application. Always use credentials assigned to
 your application upon registration with DS.
 
 ServiceName:
 This corresponds to the service id assigned to the application in the Kerberos
 KDC by Directory Services. This is a 17-digit number.
 This parameter is deprecated, will be removed with support for legacy API. Use parameter “ServiceApplicationId“ instead.
 Important note: Please, do not use Sample Application's credentials for
 authenticating your application. Always use credentials assigned to
 your application upon registration with DS.
 
 ServiceTicketData:
 This is the service ticket that is specific to the application.
 This can't be NULL.
 */

@protocol ACVerifyServiceTicketRequest <NSObject>
@property (strong) NSString * _Nonnull userName;
@property (strong) NSString * _Nonnull realm;
@property (strong) NSNumber * _Nonnull serviceApplicationId;
@property (strong) NSData * _Nonnull serviceTicketData;
@property (strong) NSString * _Nullable SAMLRequest;
@property (assign) BOOL isDAWTokenRequired;

@property (strong) NSString * _Nullable serviceName DEPRECATED_MSG_ATTRIBUTE("Use 'serviceApplicationId' instead");
@property (strong) NSString * _Nullable serviceTicketPolicyId DEPRECATED_ATTRIBUTE;
@property (strong) NSString * _Nullable serviceApplicationIdKey DEPRECATED_ATTRIBUTE;
@end

/*
 ===================
 ACVerifyServiceTicketResponse protocol
 ===================
 
 Provides methods to access data associated with response on verify service ticket request.
 
 MutualAuthenticationToken:
 This is the mutual authentication token obtained from the SSO server.
 
 PersonId:
 This is the person ID for which the service ticket was received.
 
 Error:
 This is the error message in case of any error occurred in the method call.
 */

@protocol ACVerifyServiceTicketResponse <NSObject>
@property (strong) NSError * _Nullable error;
@property (strong) NSData * _Nullable mutualAuthenticationToken;
@property (strong) NSNumber * _Nullable personId;
@property (strong) NSString * _Nullable DAWToken;
@property (strong) NSString * _Nullable SAMLToken;
@property (strong) NSDictionary * _Nullable otherVerificationResults;
@end

#endif

#endif
