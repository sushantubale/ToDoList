//
//  ACAuthenticationContextMessages.h
//  AppleConnectClient.framework
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#import AC_IMPORT(AppleConnectClientDefines.h)
#import AC_IMPORT(ACContextMessages.h)
#import AC_IMPORT(ACAuthenticationConstants.h)

#pragma mark - Authenticate

AC_CLIENT_EXPORT extern NSString * _Nonnull const kACClientMessageAppIDKey;

/// Authentication Request for Performing an Authentication with AppleConnect.
AC_CLIENT_EXPORT @interface ACAuthenticationRequest : ACRequest

///username to authenticate with AppleConnect
@property (strong) NSString * _Nullable userName;

///authType defines what kind of token / service ticket you will get after Authentication. It takes a value from the ACAuthenticationType Enum
@property (assign) ACAuthenticationType authType API_UNAVAILABLE(tvos);

///interactivityType allows you to enable and disable SSO. It takes a value from the ACInteractivityType Enum.
@property (assign) ACInteractivityType interactivityType API_UNAVAILABLE(tvos);

///canUseFallbackAuth is an option which allows you to Authenticate when AppleConnect isnt installed on the device. It isn't availabe for everyone and needs InfoSec Approval to be used in your App.
@property (assign) BOOL canUseFallbackAuth API_AVAILABLE(macos(10.13)) API_UNAVAILABLE(tvos);

///fallbackAuthClientParameters takes a dictionary of AppIDkey and other params which allows you to Authenticate when AppleConnect isn't installed on the device. For this to work, the canUseFallbackAuth property should be set true.  It isn't availabe for everyone and needs InfoSec Approval to be used in your App.
@property (strong) NSDictionary * _Nullable fallbackAuthClientParameters API_AVAILABLE(macos(10.13))  API_UNAVAILABLE(tvos);

///Must be pre-set with corresponding URL encoded SAML request when performing SAML authentication. This parameter is required for SAML authentication. Unavailable on iOS and Mac Catalyst.
@property (strong) NSString * _Nullable SAMLRequest API_UNAVAILABLE(ios, tvos);

///when cancelable is set, It allows the user to cancel authentication. It can be set only on iOS, on the mac and Mac Catalyst it is always cancelable.
@property (assign) BOOL cancelable API_UNAVAILABLE(macos);

///if you authenticate after idleExpirationTime, It will ignore the SSO ticket you have in keychain and will Ask for credentials again.
@property (assign) NSTimeInterval idleExpirationTimeout API_UNAVAILABLE(macos, tvos);
@end


/// Authentication Response After Performing an Authentication with AppleConnect.
AC_CLIENT_EXPORT @interface ACAuthenticationResponse : ACResponse

///username to authenticated with AppleConnect
@property (strong) NSString * _Nullable userName;

///service ticket received after authentication.
@property (strong) NSString * _Nullable serviceTicket;

/// personID of the username authenticate
@property (strong) NSNumber * _Nullable personID;

/// authType of the  Authentication. Same as that you gave during authetication Request
@property (assign) ACAuthenticationType authType API_UNAVAILABLE(tvos);
@end

#pragma mark - Verify Service Ticket

API_UNAVAILABLE(tvos)
AC_CLIENT_EXPORT @interface ACVerifyServiceTicketRequest : ACRequest

///username to authenticated with AppleConnect
@property (strong) NSString * _Nonnull userName;

///service ticket received after authentication. This is what will be verified
@property (strong) NSString * _Nonnull serviceTicket;
@end

API_UNAVAILABLE(tvos)
AC_CLIENT_EXPORT @interface ACVerifyServiceTicketResponse : ACResponse
@property (strong) NSDictionary * _Nullable responseInformation;
@end

#pragma mark - Legacy Interface

AC_CLIENT_EXPORT @interface ACAuthenticationRequest (AppleConnectLegacy)

@property (assign) BOOL suppressSingleSignOn DEPRECATED_MSG_ATTRIBUTE("Use 'interactivityType' instead")  API_UNAVAILABLE(macos, tvos);

@end

