//
//  AppleConnectClientLegacy.h
//  AppleConnectClient
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#ifndef	__APPLE_CONNECT_CLIENT_LEGACY_H__
#define	__APPLE_CONNECT_CLIENT_LEGACY_H__

#ifndef AC_LEGACY_EXPORT
    #define AC_LEGACY_EXPORT  __attribute__((visibility("default")))
#endif

#include <AppleConnectClient/AppleConnectClientDefines.h>
#include <AppleConnectClient/AppleConnectClientConstants.h>

#ifdef	__OBJC__

#import <AppleConnectClient/AppleConnectClientProtocol.h>
#import <AppleConnectClient/AppleConnectClientMessages.h>
#import <AppleConnectClient/ACAuthenticationConstants.h>
#import <AppleConnectClient/ACNetworkingConstants.h>

#endif

#pragma mark -
#pragma mark Legacy interfaces (Synchronious)

#define kACNotificationUsedDidLogoutKey kACNotificationUserDidLogoutKey

#ifdef __cplusplus
extern "C"	{
#endif

#include <CoreFoundation/CoreFoundation.h>

#pragma mark -
	
	/*
	 * Pointer to Sign Off callback to pass to SSOGetServiceTicket if you want to be 
	 * notified when user signed off.
	 */
	typedef void (*SSOSignOffCallbackPtr)(CFStringRef _Nonnull inUser, CFStringRef _Nonnull inRealm, CFDictionaryRef _Nonnull dict);
	
	
#pragma mark -
	
	/*
	 ============
	 SSOIsACInstalled
	 ============
	 
	 Detects if AppleConnect is installed on the machine or not
	 
	 Input Parameters:
	 ___________
	 None
	 
	 Result:
	 ___________
	 If AppleConnect is installed returns TRUE, otherwise FALSE
	 
	 */

	AC_LEGACY_EXPORT
	Boolean
	SSOIsACInstalled(
					 void
					 );
	
	/*
	 ============
	 SSOInit
	 ============
	 
	 Makes the SSO Framework initializatons
	 
	 Input Parameters:
	 ___________
	 None
	 
	 Output Parameter:
	 ___________
	 If initialization successful then 0, otherwise error code
	 
	 */		
	
	AC_LEGACY_EXPORT
	int
	SSOInit(
			void
			);
	typedef int (*SSOInitPtr)(
							  void
							  );
	
	/*
	 ===================
	 SSOGetServiceTicket
	 ===================
	 
	 Retrieves service ticket for a user, pop-up Sign On UI as necessary.
	 
	 Parameters:
	 ___________
	 
	 inRealm :	
	 This indicates which Kerberos Realm the app is connecting to - i.e. Dev or Test or Production.  
	 eg. "KRB-DEV.APPLE.COM"
	 Cannot be Null.
	 
	 inEnv   : 
	 Default value is "INT".
	 Cannot be null.
	 
	 inServiceName   :
	 The Service Name as registered in Kerberos.  
	 eg. adir-dev
	 Cannot be Null.
	 Important note: Please, do not use Sample Application's credentials for 
					 authenticating your application. Always use credentials assigned to 
					 your application upon registration with DS. 
	 
	 inServiceHost :
	 The host on which the service ticket gets verified.   
	 eg. ets3.apple.com
	 Cannot be Null.
	 
	 inUserName: 
	 If the user name is null, then an attempt is made to fetch a service ticket for the current user 
	 (the current user can be determined by looking at the Kerberos User list window - the topmost user 
	 is the current one).
	 
	 If the user name is not null then an attempt is made to fetch the service ticket for the provided 
	 user.
	 
	 In appropriate cases the SSO Login Window is popped up.
	 
	 inCallbck
	 If you interesting to be notified when successfully Signed On user gets Signed Off, pass pointer
	 to your callback routine of type SSOSignOffCallbackPtr. This callback will be called when user 
	 signed off.
	 Can be NULL.
	 
	 inClientSpecificParameters :
	 App specific additional parameters dictionary.
	 Can be NULL.
	 
	 outUserName:
	 This is the user name for which the service ticket was received.
	 Cannot be NULL, you wanna know user name, right?
	 If return value is not NULL, caller responsible for releasing object.
	 
	 outServiceTicket: 
	 This is the service ticket received
	 Cannot be NULL, this is what you are looking for, after all...
	 If return value is not NULL, caller responsible for releasing object.
	 
	 outContext :
	 This context is to be retained by the calling app for post login purposes.
	 Post Login will take care of proper releasing. Don't expect context to have any 
	 meaning to the client app, or be accessible from the context of the calling app.
	 Cannot be NULL.
	 
	 outClientSpecificResults :
	 If not zero may be populated with additional parameters dictionary. 
	 Can be NULL.
	 If return value is not NULL, caller responsible for releasing object.
	 
	 outErrorMessage :
	 This is the error message.  This will be populated if the function return is not kSSO_NoErr.  
	 Can be NULL, in case you don't care ;)
	 If return value is not NULL, caller responsible for releasing object.
	 
	 */
	

	AC_LEGACY_EXPORT
	int SSOGetServiceTicket(
							CFStringRef _Nonnull    	    inRealm,
							CFStringRef _Nonnull		    inEnv,
							CFStringRef _Nonnull			inServiceName,
							CFStringRef _Nonnull			inServiceHost,
							CFStringRef _Nullable			inUsername,
							SSOSignOffCallbackPtr _Nullable	inCallbck,
							CFDictionaryRef _Nullable		inClientSpecificParameters,
							CFStringRef _Nullable * _Nonnull outUsername,
							CFDataRef _Nullable * _Nonnull 	outServiceTicket,
							void * _Nullable * _Nonnull     outContext,
							CFDictionaryRef _Nullable * _Nullable outClientSpecificResults,
							CFStringRef _Nullable * _Nullable outErrorMessage
							);
	typedef int (* SSOGetServiceTicketPtr)(
										   CFStringRef _Nonnull 			inRealm,
										   CFStringRef _Nonnull			    inEnv,
										   CFStringRef _Nonnull			    inApp,
										   CFStringRef _Nonnull			    inAppHost,
										   CFStringRef _Nullable			inUsername,
										   SSOSignOffCallbackPtr _Nullable	inCallbck,
										   CFDictionaryRef _Nullable		inClientSpecificParameters,
										   CFStringRef _Nullable * _Nonnull outUsername,
										   CFDataRef _Nullable * _Nonnull 	outServiceTicket,
										   void * _Nullable * _Nonnull		outContext,
										   CFDictionaryRef _Nullable * _Nullable outClientSpecificResults,
										   CFStringRef _Nullable * _Nullable outErrorMessage
										   );
	
	/*
	 ============
	 SSOPostLogin
	 ============
	 
	 Authenticates server
	 
	 Parameters:
	 ___________
	 
	 inContext :
	 Context returned on call to SSOGetServiceTicket.
	 Cannot be NULL.
	 
	 inMutualAuthToken :
	 Mutual Authentication Token.
	 Cannot be NULL.
	 
	 inClientSpecificParameters :
	 App specific additional parameters dictionary. TBD.
	 Can be NULL.
	 
	 outClientSpecificResults :
	 If not zero may be populated with additional parameters dictionary. 
	 Can be NULL.
	 If return value is not NULL, caller responsible for releasing object.
	 
	 outErrorMessage :
	 This is the error message.  This will be populated if the return int is not zero.  
	 Can be NULL, in case you don't care ;)
	 If return value is not NULL, caller responsible for releasing object.
	 */		
	
	AC_LEGACY_EXPORT
	int SSOPostLogin( 
					 void* _Nonnull				inContext,
					 CFDataRef _Nonnull			inMutualAuthToken,
					 CFDictionaryRef _Nullable	inClientSpecificParameters,
					 CFDictionaryRef _Nullable * _Nullable 	outClientSpecificResults,
					 CFStringRef _Nullable * _Nullable		outErrorMessage
					 );
	typedef int (*SSOPostLoginPtr)( 
								   void* _Nonnull				inContext,
								   CFDataRef _Nonnull			inMutualAuthToken,
								   CFDictionaryRef _Nullable 	inClientSpecificParameters,
								   CFDictionaryRef _Nullable * _Nullable 	outClientSpecificResults,
								   CFStringRef _Nullable * _Nullable 		outErrorMessage
								   );
	
	/*
	 ============
	 SSOGetCurrentSSOUserName
	 ============
	 
	 Retrieves copy of the current SSO user name for specified realm, if exist.
	 
	 COMPATIBILITY: Requires AppleConnect 2.2 or newer. If used with earlier version of AC, it will return kSSO_FeatureNotImplementedErr error
	 
	 Parameters:
	 ___________
	 
	 inRealm :
	 The name of the realm. Required, can not be NULL. If set to NULL, kSSO_InvalidParamErr returned.
	 
	 outUserName :
	 Mandatory, can not be NULL. If set to NULL, kSSO_InvalidParamErr returned.
	 On return, populated with the name of user available for SSO. If no user signed in for realm, or user is expired, *outUserName is set to NULL. 
	 If not NULL, returned reference must be released by calling CFRelease().
	 */		
  
	AC_LEGACY_EXPORT
	int SSOGetCurrentSSOUserName(
								 CFStringRef _Nonnull			    inRealm,
								 CFStringRef _Nullable * _Nonnull	outUserName
								 );
	typedef int (*SSOGetCurrentSSOUserNamePtr)(
											   CFStringRef _Nonnull			    inRealm,
											   CFStringRef _Nullable * _Nonnull	outUserName
											   );
	
	
	/*
	 ======================
	 SSOVerifyServiceTicket
	 ======================
	 
	 Server-side counterpart of SSOGetServiceTicket. Validates service ticket returned by SSOGetServiceTicket. Retrieves user parameters such as DS Person ID, etc.
	 Generates Mutual Authentication Token, for the verification on the client in the PostLogin call. 
	 
	 COMPATIBILITY: Requires AppleConnect 2.2 or newer. If used with earlier version of AC, it will return kSSO_FeatureNotImplementedErr error
	 
	 Parameters:
	 ___________
	 
	 inUsername:
	 Username associated with the ticket
	 Cannot be Null.
	 
	 inRealm :	
	 This indicates which Kerberos Realm the app is connecting to - i.e. Dev or Test or Production.  
	 eg. "KRB-DEV.APPLE.COM"
	 Cannot be Null.
	 
	 inEnv   : 
	 Default value is "INT".
	 Cannot be null.
	 
	 inServiceName   :
	 The Service Name as registered in Kerberos.  
	 eg. adir-dev
	 Cannot be Null.
	 Important note: Please, do not use Sample Application's credentials for 
					 authenticating your application. Always use credentials assigned to 
					 your application upon registration with DS. 
	 
	 inAppID :
	 Service application credentials ID. Assigned to application on registration with DS. Usually a small number, like 229. This cannot be NULL.
	 Important note: Please, do not use Sample Application's credentials for 
					 authenticating your application. Always use credentials assigned to 
					 your application upon registration with DS. 
	 
	 inServiceTicket :
	 Cannot be Null
	 
	 inClientSpecificParameters :
	 Currently unused
	 
	 outPersonID :
	 Cannot be Null
	 If return value is not NULL, caller responsible for releasing object.
	 
	 outMutualAuthToken :
	 Cannot be NULL.
	 If return value is not NULL, caller responsible for releasing object.
	 
	 outClientSpecificResults :
	 If not zero may be populated with additional parameters dictionary. 
	 Can be NULL.
	 If return value is not NULL, caller responsible for releasing object.
	 
	 outErrorMessage :
	 This is the error message.  This will be populated if the function return is not kSSO_NoErr.  
	 Can be NULL, in case you don't care ;)
	 If return value is not NULL, caller responsible for releasing object.
	 
	 */
  
	AC_LEGACY_EXPORT
	int SSOVerifyServiceTicket(
							   CFStringRef _Nonnull			inUsername,
							   CFStringRef _Nonnull			inRealm,
							   CFStringRef _Nonnull			inEnv,
							   CFStringRef _Nonnull			inServiceName,
							   CFNumberRef _Nonnull			inAppID,
							   CFDataRef _Nonnull			inServiceTicket,
							   CFDictionaryRef _Nullable	inClientSpecificParameters,
							   CFNumberRef _Nullable * _Nonnull outPersonID,
							   CFDataRef _Nullable * _Nonnull outMutualAuthToken,
							   CFDictionaryRef _Nullable * _Nullable outClientSpecificResults,
							   CFStringRef _Nullable * _Nullable outErrorMessage
							   );
	typedef int (*SSOVerifyServiceTicketPtr)(
											 CFStringRef _Nonnull			inUsername,
											 CFStringRef _Nonnull			inRealm,
											 CFStringRef _Nonnull			inEnv,
											 CFStringRef _Nonnull			inServiceName,
											 CFNumberRef _Nonnull			inAppID,
											 CFDataRef _Nonnull			    inServiceTicket,
											 CFDictionaryRef _Nullable		inClientSpecificParameters,
											 CFNumberRef _Nullable * _Nonnull outPersonID,
											 CFDataRef _Nullable * _Nonnull outMutualAuthToken,
											 CFDictionaryRef _Nullable * _Nullable outClientSpecificResults,
											 CFStringRef _Nullable * _Nullable outErrorMessage
											 );
    
    
    /*
	 ============
	 SSOIsSingleSignOnEnabled
	 ============
	 
	 Checks if Use Sign On preference is enabled or not
	 
	 Parameters:
	 ___________
	 outIsSingleSignOnEnabled: 
     On return  If 'Use Sign On' preference is enabled it will set to TRUE, otherwise FALSE
	 
	 */
  
	AC_LEGACY_EXPORT
	int SSOIsSingleSignOnEnabled(Boolean * _Nonnull outIsSingleSignOnEnabled );
	typedef int (*SSOIsSingleSignOnEnabledPtr)(Boolean * _Nonnull outIsSingleSignOnEnabled);

	
#ifdef	__cplusplus
}
#endif

#endif
