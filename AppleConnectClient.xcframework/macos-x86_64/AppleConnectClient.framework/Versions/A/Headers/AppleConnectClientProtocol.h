//
//  AppleConnectClientProtocol.h
//  AppleConnectClient
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#ifndef	__APPLE_CONNECT_CLIENT_PROTOCOL_H__
#define	__APPLE_CONNECT_CLIENT_PROTOCOL_H__

#ifndef AC_LEGACY_EXPORT
    #if TARGET_OS_OSX
        #define AC_LEGACY_EXPORT __attribute__((visibility("default")))
    #else
        #define AC_LEGACY_EXPORT  __attribute__((visibility("hidden")))
    #endif
#endif

#ifdef	__OBJC__

#import <Foundation/Foundation.h>

@protocol ACAppleConnectClientProtocol;
@protocol ACAppleConnectClientDelegate;
@protocol ACAuthenticationRequest;
@protocol ACAuthenticationResponse;
@protocol ACPostLoginRequest;
@protocol ACPostLoginResponse;
@protocol ACVerifyServiceTicketRequest;
@protocol ACVerifyServiceTicketResponse;

#pragma mark - Factory method and Main class

#ifdef __cplusplus
extern "C"    {
#endif
    
    /*
     ===================
     SSOCreateAppleConnectClient
     ===================
     
     This API initializes the AppleConnectClient singleton instance.
     
     Parameters:
     ___________
     
     IsStealthModeEnabled:
     If this parameter is set to NO, alert about not installed AppleConnect
     will appear anytime when client is trying to use functionality of AppleConnect.
     
     Result:
     ___________
     
     This API returns the not autoreleased object which conforms to the protocol 'ACAppleConnectClientProtocol'
     and has retain count = 1. After creation of AppleConnectClient singleton
     instance you need to set it up with the delegate which conforms to the
     'ACAppleConnectClientDelegate' protocol, and implement all required protocol interfaces.
     */
    
    AC_LEGACY_EXPORT id<ACAppleConnectClientProtocol> _Nullable SSOCreateAppleConnectClient(BOOL isStealthModeEnabled);
    typedef id<ACAppleConnectClientProtocol> _Nullable (*SSOCreateAppleConnectClientPtr)(BOOL isStealthModeEnabled);
    
    AC_LEGACY_EXPORT void SSOReleaseAppleConnectClient(id<ACAppleConnectClientProtocol> _Nonnull * _Nonnull appleConnectClient);
    typedef void (*SSOReleaseAppleConnectClientPtr)(id<ACAppleConnectClientProtocol> _Nonnull * _Nonnull appleConnectClient);
#ifdef __cplusplus
}
#endif

/*
 ===================
 ACAppleConnectClientProtocol
 ===================
 
 Provides interface for the set of methods which are used for authentication and
 perform VPN connection within AppleConnect.
 */

@protocol ACAppleConnectClientProtocol <NSObject>

/*
 Accessors methods which are used to access the delegate instance that should conform
 to 'ACAppleConnectClientDelegate' protocol and implementing all required and perhaps
 optional protocol methods.
 */

@property (assign) id<ACAppleConnectClientDelegate> _Nullable delegate;

/*
 Returns current version of installed AppleConnect in long format, i.e. 2.9.8.2 (859).
 */

@property (readonly) NSString * _Nonnull version;

/*
 Returns current version of installed AppleConnect in short format, i.e. 2.9.8.2.
 */

@property (readonly) NSString * _Nonnull shortVersion;

/*
 Returns current bundle version of installed AppleConnect, i.e. 859.
 */

@property (readonly) NSString * _Nonnull bundleVersion;

/*
 ===================
 suggestUserNameForRealm:
 ===================
 
 Retrieves copy of the current SSO user name for specified realm, if exist.
 
 Input Parameters:
 ___________
 
 ARealm:
 The name of the realm.
 */

- (NSString * _Nullable)suggestUserNameForRealm:(NSString * _Nullable)aRealm;

/*
 ===================
 authenticationRequest
 ===================
 
 Factory method. Returns an instance of authenticationRequest. This instance is used for authentication
 and has setter methods for mandatory and optional parameters.
 Client must specify all mandatory parameters.
 
 Input Parameters:
 ___________
 None
 
 Result:
 ___________
 AuthenticationRequest instance.
 */

- (id<ACAuthenticationRequest> _Nonnull)authenticationRequest;

/*
 ===================
 authenticate:
 ===================
 
 Provides authentication with the appropriate request. AppleConnect uses appleConnectClient:authenticationDidEndWithResponse: 
 selector to send response to delegate.
 
 Input Parameters:
 ___________
 
 ARequest:
 AuthenticationRequest instance with specified parameters. 
 It contains all necessary information for authentication request.
 */

- (void)authenticate:(id<ACAuthenticationRequest> _Nonnull)aRequest;

/*
 ===================
 authenticate:withPassword:
 ===================
 
 Provides authentication with the appropriate request. In this case Sign In view won't be shown. 
 AppleConnect uses 'appleConnectClient:authenticationDidEndWithResponse:' selector to send response to delegate.
 
 Input Parameters:
 ___________
 
 ARequest:
 AuthenticationRequest instance with specified parameters. 
 It contains all necessary information for authentication request.
 
 APassword:
 User password associated with account name.
 */

- (void)authenticate:(id<ACAuthenticationRequest> _Nonnull)aRequest withPassword:(NSString * _Nullable)aPassword;

/*
 ===================
 postLoginRequest
 ===================
 
 Factory method. Returns an instance of postLoginRequest. This instance is used for post login procedure
 and has setter methods for mandatory and optional parameters.
 Client must specify all mandatory parameters.
 
 Input Parameters:
 ___________
 None
 
 Result:
 ___________
 PostLoginRequest instance.
 */

- (id<ACPostLoginRequest> _Nonnull)postLoginRequest;

/*
 ===================
 postLogin:
 ===================
 
 Provides post login procedure with the appropriate request. AppleConnect uses 'appleConnectClient:postLoginDidEndWithResponse:' selector to send response to delegate.
 
 Input Parameters:
 ___________
 
 ARequest:
 PostLoginRequest instance. It contains all necessary information for post login request.
 */

- (void)postLogin:(id<ACPostLoginRequest> _Nonnull)aRequest;

/*
 ===================
 verifyServiceTicketRequest
 ===================
 
 Factory method. Returns an instance of verifyServiceTicketRequest. This instance is used in
 verification of received service ticket. All parameters are mandatory.
 
 Input Parameters:
 ___________
 None
 
 Result:
 ___________
 VerifyServiceTicketRequest instance.
 */

- (id<ACVerifyServiceTicketRequest> _Nonnull)verifyServiceTicketRequest;

/*
 ===================
 VerifyServiceTicket:
 ===================
 
 Provides verification of received service ticket with the appropriate request.
 Asynchronously performs ticket verification. AppleConnect uses
 appleConnectClient:verifyServiceTicketDidEndWithResponse: selector is used by
 AppleConnect to send response to delegate.
 
 Input Parameters:
 ___________
 
 ARequest:
 VerifyServiceTicketRequest instance with specified fields (see above). It contains
 all necessary information for verification of received service ticket request.
 */

- (void)verifyServiceTicket:(id<ACVerifyServiceTicketRequest> _Nonnull)aRequest;

/*
 ===================
 isNetworkConnected
 ===================
 
 Returns YES if you are connected to the Apple Network, otherwise returns NO.
 */

- (BOOL)isNetworkConnected;

/*
 ===================
 isNetworkConfigured
 ===================
 
 Returns YES if Apple Network is configured, otherwise returns NO.
 */

- (BOOL)isNetworkConfigured;

/*
 ===================
 networkConnectionType
 ===================

 Returns type of the connected network.
*/

- (NSString * _Nonnull)networkConnectionType;

/*
 ===================
 connectToNetwork
 ===================
 
 Allows client connect to Apple Network.
 */

- (void)connectToNetwork;

/*
 ===================
 disconnectFromNetwork
 ===================
 
 Allows client disconnect from Apple Network.
 */

- (void)disconnectFromNetwork;

/*
 ===================
 isSingleSignOnEnabled
 ===================
 
 Returns YES if Use Single Sign On preference is enabled, otherwise returns NO.
 */

- (BOOL)isSingleSignOnEnabled;

/*
 ===================
 isSSOEnabledForServiceName
 ===================
 
 Returns NO if Use Single Sign On preference is disabled or SSO is disabled for particular app for specified realm, otherwise returns YES.
 */

- (BOOL)isSSOEnabledForServiceName:(NSString * _Nonnull)serviceName realm:(NSString * _Nullable)realm;

@end

#pragma mark - Delegate protocol

/*
 ===================
 ACAppleConnectClientDelegate protocol
 ===================
 
 Provides interface for the set of required methods which are used for finishing
 response on 'GetServiceTicket', 'VerifyServiceTicket' and 'PostLogin' requests.
 Also it provides interface for the set of optional methods which are used for
 handling notifications on user's sign in or user's sign out and VPN state changes.
 Client need to realized all required methods.
 */

@protocol ACAppleConnectClientDelegate <NSObject>

@required
/*
 ===================
 appleConnectClient:authenticationDidEndWithResponse:
 ===================
 
 This method is invoked after response on authentication request has been received.
 
 Parameters:
 _____________
 
 Client:
 AppleConnectClient singleton instance which conforms to the protocol 'ACAppleConnectClientProtocol'. 
 
 AResponse:
 Object which conforms to the 'ACAuthenticationResponse' protocol and contains all
 necessary information about response on authentication request. 
 */

- (void)appleConnectClient:(id<ACAppleConnectClientProtocol> _Nonnull)client authenticationDidEndWithResponse:(id<ACAuthenticationResponse> _Nonnull)aResponse;

/*
 ===================
 appleConnectClient:postLoginDidEndWithResponse:
 ===================
 
 This method is invoked after response on postLogin request has been received.
 
 Parameters:
 _____________
 
 Client:
 AppleConnectClient singleton instance which conforms to the protocol 'ACAppleConnectClientProtocol'. 
 
 AResponse:
 Object which conforms to the 'ACPostLoginResponse' protocol and contains all
 necessary information about response on postLogin request. 
 */

- (void)appleConnectClient:(id<ACAppleConnectClientProtocol> _Nonnull)client postLoginDidEndWithResponse:(id<ACPostLoginResponse> _Nonnull)aResponse;

@optional

/*
 ===================
 appleConnectClient:verifyServiceTicketDidEndWithResponse:
 ===================
 
 This method is invoked after response on verifyServiceTicket request has been received.
 
 Parameters:
 _____________
 
 Client:
 AppleConnectClient singleton instance which conforms to the protocol 'ACAppleConnectClientProtocol'. 
 
 AResponse:
 Object which conforms to the 'ACVerifyServiceTicketResponse' protocol and 
 contains all necessary information about response on verifyServiceTicket request.
 */

- (void)appleConnectClient:(id<ACAppleConnectClientProtocol> _Nonnull)client verifyServiceTicketDidEndWithResponse:(id<ACVerifyServiceTicketResponse> _Nonnull)aResponse;

/*
 ===================
 appleConnectUserDidSignInNotification:
 ===================
 
 This method is invoked after notification was received that the user performed an action 'Sign In'.
 
 Parameters:
 _____________
 
 ANotification:
 Notification that was received after the user performed an action 'Sign In'.
 Contains all necessary information related to this event. 
 */

- (void)appleConnectUserDidSignInNotification:(NSNotification * _Nonnull)aNotification;

/*
 ===================
 appleConnectUserDidSignOutNotification:
 ===================
 
 This method is invoked after notification was received that the user performed an action 'Sign Out'.
 
 Parameters:
 _____________
 
 AResponse:
 Notification that was received after the user performed an action 'Sign Out'.
 Contains all necessary information related to this event. 
 */

- (void)appleConnectUserDidSignOutNotification:(NSNotification * _Nonnull)aNotification;

/*
 ===================
 appleConnectNetworkStateDidChangeNotification:
 ===================
 
 Optional delegate method which is invoked after notification was received that
 Apple Network state has been changed.
 
 Parameters:
 _____________
 
 AResponse:
 Notification that was received after the Apple Network state has been changed. 
 Contains all necessary information related to this event.
 */

- (void)appleConnectNetworkStateDidChangeNotification:(NSNotification * _Nonnull)aNotification;

@end

#endif

#endif
