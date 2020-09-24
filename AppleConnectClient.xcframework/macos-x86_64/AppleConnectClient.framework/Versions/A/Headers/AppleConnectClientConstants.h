//
//  AppleConnectClientConstants.h
//  AppleConnectClient
//
//  Created by Anton Pereidenko on 1/29/19.
//  Copyright © 2019 Apple Inc. All rights reserved.
//

#ifndef	__APPLE_CONNECT_CLIENT_CONSTANTS_H__
#define	__APPLE_CONNECT_CLIENT_CONSTANTS_H__

#ifdef	__OBJC__
	#define AC_CONST_STR(X) @"" X ""
#else
	#define AC_CONST_STR(X) CFSTR(X)
#endif

#pragma mark - Error Constants

enum
{
    kACSuccess                                      = 0,
    
    kACErrorUserNotLoggedIn                         = -100100,
    kACErrorUserLoginExpired                        = -100101,
    kACErrorAccountPasswordIsInvalid                = -100102,
    kACErrorAccountDoesNotExistInKDC                = -100103,
    kACErrorAccountPasswordIsExpired                = -100104,
    kACErrorNoUsersLoggedIn                         = -100105,
    
    kACErrorAccountCredentialsMismatch              = -100110,
    
    kACErrorAccountNameIsInvalid                    = -100115,
    kACErrorAccountCredentialsRevoked               = -100116,
    kACErrorAccountIsLocked                         = -100117,
    kACErrorAccountIsExpired                        = -100118,
    kACErrorAccountPasswordChangingFailed           = -100119,
    
    kACErrorServiceDoesNotExist                     = -100120,
    kACErrorServiceHostnameDoesNotExist             = -100121,
    kACErrorServiceHostnameFormat                   = -100122,
    kACErrorServiceAccountExpired                   = -100123,
    kACErrorServiceTokenIllegal                     = -100124,
    
    kACErrorClientMutualAuthFailure                 = -100130,
    
    kACErrorKDCIsNotAvailable                       = -100140,
    
    kACErrorKerberosConfigFileDoesNotExist          = -100150,
    kACErrorKerberosConfigFileFormat                = -100151,
    kACErrorKerberosConfigFileDefaultRealm          = -100152,
    
    kACErrorRealmInavalid                           = -100160,
    kACErrorEnvironmentNameInavalid                 = -100161,
    
    kACErrorSystemClockSkew                         = -100180,
    
    kACErrorChangePasswordNetworkFailure            = -100351,
    kACErrorFailoverAuthNetworkFailure              = -100352,
    kACErrorServerResponse                          = -100360,
    kACErrorFailoverAuthServerResponse              = -100362,
    kACErrorChangePasswordWebServiceTimeout         = -100363,
    kACErrorFOVerifyTokenWebServiceTimeout          = -100364,
    
    kACErrorChangePasswordAuthenticationFailed      = -100370,
    kACErrorChangePasswordFailed                    = -100371,
    kACErrorChangePasswordUnableToGetRules          = -100375,
    
    kACErrorNetworkIsNotAvailable                   = -100401,
    kACErrorWebServiceNetworkTimeout                = -100402,
    kACErrorWebServiceFailure                       = -100403,
    kACErrorNetworkFailure                          = -100404,
    
    kACErrorNetworkProvisioningAuthorizationFailure = -100600,
    kACErrorNetworkIncorrectConfiguration           = -100602,
    kACErrorCSRGenerationError                      = -100605,
    kACErrorNetworkCertificateNumberLimitFailure    = -100607,
    kACErrorNetworkGetCertificateNetworkFailure     = -100608,
    kACErrorNetworkAdminAuthorizationCancelled      = -100611,
    kACErrorNetworkGetCertificateServerIsDown       = -100612,
    kACErrorNetworkSecurityTestRequired             = -100613,
    
    kACErrorDeviceProvisioningResponseFailure       = -100609,
    kACErrorDeviceProvisioningNetworkTimeout        = -100610,
    
    kACErrorVPNGetPPPCredentialsNetworkFailure      = -100620,
    kACErrorVPNGetPPPCredentialsNetworkTimeout      = -100621,
    kACErrorVPNGetPPPCredentialsResponseFailure     = -100622,
    
    kACErrorVPNConfigurationFailure                 = -100630,
    
    kACErrorSSOApplicationNotInstalled              = -200000,
    kACErrorAppleConnectNotInstalled                = -200001,
    
    kACErrorIPCFailed                               = -200010,
    
    kACErrorSSOApplicationQuit                      = -200020,
    kACErrorModeNotSupportedForEnvironment          = -200030,
    kACErrorFeatureNotImplemented                   = -200040,
    
    kACErrorUserCancel                              = -200050,
    kACErrorUserMismatch                            = -200070,
    
    kACErrorInvalidParam                            = -200190,
    kACErrorInvalidTicketData                       = -200192,
    
    kACErrorMisc                                    = -200200,
    kACErrorAPI                                     = -200300,
};

#pragma mark -

#define kSSOEnvironmentInternal                 AC_CONST_STR("INT")
#define kSSOEnvironmentFailover                 AC_CONST_STR("FAIL")

#pragma mark - Notifications

#define kACUserDidSignInNotification AC_CONST_STR("com.apple.ist.ds.appleconnect.userDidSignIn")
#define kACUserDidSignOutNotification AC_CONST_STR("com.apple.ist.ds.appleconnect.userDidSignOut")
#define kACNetworkStateDidChangeNotification AC_CONST_STR("com.apple.ist.ds.appleconnect.NetworkStateDidChange")

#define kACNotificationRealmKey @"realm"

/* Correspondent value of type CFBoolean which indicates whether user been signed out because of inactivity or voluntarily */
#define	kSSOIsUserSignedOut						AC_CONST_STR("SSOIsUserSignedOut")		

/*
 =====================================================================================
 Dictionary keys for use with inClientSpecificParameters and outClientSpecificResults
 =====================================================================================
 */
/* 
 * Use kSSOKeyAppName key to pass human readable application name which may be 
 * displayed in Sign On UI. Correspondent value of type CFString.
 */
#define	kSSOKeyAppName							AC_CONST_STR("SSOKeyAppName")

/*
 * Use kSSOKeyStealthMode key to indicate interfaceless application. Correspondent 
 * value of CFBooleanRef type, TRUE - for interfaceless session. No UI will be 
 * invoked during interfaceless SSOGetServiceTicket or SSOPostLogin sessions. Be   
 * sure to specify kSSOKeyStealthModeParameters along in the dictionary. 
 */
#define	kSSOKeyStealthMode						AC_CONST_STR("SSOKeyStealthMode")

/*
 * Use kSSOKeyStealthModeParameters key to pass stealth mode parameters for calls to
 * SSOGetServiceTicket or SSOPostLogin sessions. Correspondent value of CFStringRef type.
 */
#define	kSSOKeyStealthModeParameters			AC_CONST_STR("SSOKeyStealthModeParameters")

/*
 * Use kSSOKeyRunningInAppletMode key to indicate when API is calling from browser applet.
 * Correspondent value of CFBooleanRef type, TRUE - for applet session. No alert boxes 
 * will be invoked from context of the applet during SSOGetServiceTicket or SSOPostLogin sessions.
 */
#define	kSSOKeyAppletMode						AC_CONST_STR("SSOKeyAppletMode")

/*
 * Use kSSOKeyShowProgress key if you want to show AppleConnect progress window while signing in process.
 * Correspondent value of CFBooleanRef type, TRUE - if prograss window required.
 */
#define	kSSOKeyShowProgress						AC_CONST_STR("SSOKeyShowProgress") DEPRECATED_ATTRIBUTE

/*
 * Use kSSOKeyShowUnInstallErrorForExternal key to decide for External Clients whether to Show the error or not when AppleConnect is not Installed
 */
#define	kSSOKeyShowUnInstallErrorForExternal	AC_CONST_STR("SSOKeyShowUnInstallErrorForExternal")

/*
 * This is used with the outClientSpecificResults. This key indicates whether Single Sign On is used or not.
 * 'Single Sign On' is used when there is no need to authenticate the user by popping Sign In window 
 * as credentials are already present.
 * This is added purely for Profiling or Debugging purposes only.
 */
#define	kIsSingleSignOnUsed						AC_CONST_STR("IsSingleSignOnUsed")

/*
 * Use kSSOKeyShouldIgnoreSSO key if you want to ignore Single Sign On for the particular SSOGetServiceTicket request.
 * Correspondent value of CFBooleanRef type. Default value is FALSE.
 */
#define	kSSOKeyShouldIgnoreSSO                  AC_CONST_STR("SSOKeyShouldIgnoreSSO")

#endif
