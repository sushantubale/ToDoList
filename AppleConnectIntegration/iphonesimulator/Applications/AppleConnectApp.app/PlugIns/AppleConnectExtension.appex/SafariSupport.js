var ACMIExtensionJavaScriptClass = function() {};

ACMIExtensionJavaScriptClass.prototype = {
run: function(arguments) {
    
    var event = new CustomEvent("acmi-did-start-message",
                                    { 'detail': {}
                                    }
                                );
    
    window.dispatchEvent(event);

    var signin = document.forms["acmForm"];
    if (null == signin) {
        arguments.completionFunction({"error": "no acm form"});
        return;
    }
    
    var appID = signin.elements["appId"].value;
    if (null == appID) {
        arguments.completionFunction({"error": "no appId"});
        return;
    }

    var account = signin.elements["accountName"].value;
    
    var e = signin.elements["environment"].value;
    var environment = 0;
    if ("UAT" == e) {
        environment = "1";
    }
    
    var idleExpirationTimeout = "28800"; // ACMI ignores it, if non-float value
    if (null != signin.elements["ssoEnable"]) {
        var ssoEnable = signin.elements["ssoEnable"].value;
        if ("N" == ssoEnable) {
            idleExpirationTimeout = "0";
        }
    }

    arguments.completionFunction({
                                 "baseURI": document.baseURI,
                                 "account": account,
                                 "appID": appID,
                                 "idleExpirationTimeout": idleExpirationTimeout,
                                 "environment": environment
                                 });
},
    
finalize: function(arguments) {
    if (null == arguments["openURL"]) {
        var event = new CustomEvent("acmi-response-message",
                                    {
                                        'detail': { method: "authenticate",
                                            parameters:{
                                                'accountName': arguments["account"],
                                                'DSID': arguments["DSID"],
                                                'acmToken': arguments["token"],
                                                'error': arguments["error"],
                                                'errorDescription': arguments["errorDescription"]
                                            }
                                        }
                                    });
        
        window.dispatchEvent(event);
    } else {
        var event = new CustomEvent("acmi-open-url",
                                    {
                                        'detail': { URL: arguments["openURL"] }
                                    });
        window.dispatchEvent(event);
    }
}
};

var ExtensionPreprocessingJS = new ACMIExtensionJavaScriptClass;
