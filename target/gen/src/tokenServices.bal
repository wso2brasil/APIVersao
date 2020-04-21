import ballerina/http;
import wso2/gateway;

@http:ServiceConfig {
    basePath:"/authorize"
     
}
@gateway:Filters {
    skipAll: true
}
service authorizeService on tokenListenerEndpoint, apiSecureListener {

    @http:ResourceConfig {
        path: "/*"
    }
    resource function authorizeResource(http:Caller caller, http:Request req) {
        gateway:checkExpectHeaderPresent(req);
        var response = gateway:keyValidationEndpoint->forward(gateway:getConfigValue(gateway:KM_CONF_INSTANCE_ID, gateway:KM_TOKEN_CONTEXT, "/oauth2") +
                untaint req.rawPath, req);
        if(response is http:Response)   {
            var outboundResult = caller->respond(response);
            if (outboundResult is error) {
                log:printError("Error when sending authorize endpoint response", err = outboundResult);
            }
        }
        else  {
            log:printError("Error while invoking authorize endpoint", err = response);
            http:Response errorResponse = new;
            json errMsg = { "error": "error occurred while invoking the authorize endpoint" };
            errorResponse.setJsonPayload(errMsg);
            _ = caller->respond(errorResponse);
        }

    }
}

@http:ServiceConfig {
    basePath:"/token"
    
}
@gateway:Filters {
    skipAll: true
}
service tokenService on tokenListenerEndpoint, apiSecureListener {

    @http:ResourceConfig {
        path: "/*"
    }
    resource function tokenResource(http:Caller caller, http:Request req) {
        gateway:checkExpectHeaderPresent(req);
        var response = gateway:keyValidationEndpoint->forward(gateway:getConfigValue(gateway:KM_CONF_INSTANCE_ID, gateway:KM_TOKEN_CONTEXT, "/oauth2") +
                untaint req.rawPath, req);
        if(response is http:Response) {
            var outboundResult = caller->respond(response);
            if (outboundResult is error) {
                log:printError("Error when sending token endpoint response", err = outboundResult);
            }
        }
        else {
            log:printError("Error while invoking token endpoint", err = response);
            http:Response errorResponse = new;
            json errMsg = { "error": "error occurred while invoking the token endpoint" };
            errorResponse.setJsonPayload(errMsg);
            _ = caller->respond(errorResponse);
        }
    }
}


@http:ServiceConfig {
    basePath:"/revoke"
    
}
@gateway:Filters {
    skipAll: true
}
service revokeService on tokenListenerEndpoint, apiSecureListener {

    @http:ResourceConfig {
        path: "/*"
    }
    resource function revokeResource(http:Caller caller, http:Request req) {
        gateway:checkExpectHeaderPresent(req);
        var response = gateway:keyValidationEndpoint->forward(gateway:getConfigValue(gateway:KM_CONF_INSTANCE_ID, gateway:KM_TOKEN_CONTEXT, "/oauth2") +
                untaint req.rawPath, req);
        if(response is http:Response) {
            var outboundResult = caller->respond(response);
            if (outboundResult is error) {
                log:printError("Error when sending revoke endpoint response", err = outboundResult);
            }
        } else {
            log:printError("Error while invoking revoke endpoint", err = response);
            http:Response errorResponse = new;
            json errMsg = { "error": "error occurred while invoking the revoke endpoint" };
            errorResponse.setJsonPayload(errMsg);
            _ = caller->respond(errorResponse);
        }

    }
}

@http:ServiceConfig {
    basePath:"/userinfo"
    
}
@gateway:Filters {
    skipAll: true
}
service userInfoService on tokenListenerEndpoint, apiSecureListener {

    @http:ResourceConfig {
        path: "/*"
    }
    resource function userInfoResource(http:Caller caller, http:Request req) {
        gateway:checkExpectHeaderPresent(req);
        var response = gateway:keyValidationEndpoint->forward(gateway:getConfigValue(gateway:KM_CONF_INSTANCE_ID, gateway:KM_TOKEN_CONTEXT, "/oauth2") +
                untaint req.rawPath, req);
        if(response is http:Response) {
            var outboundResult = caller->respond(response);
            if (outboundResult is error) {
                log:printError("Error when sending user info endpoint response", err = outboundResult);
            }
        }
        else {
            log:printError("Error while invoking user info endpoint", err = response);
            http:Response errorResponse = new;
            json errMsg = { "error": "error occurred while invoking the user info endpoint" };
            errorResponse.setJsonPayload(errMsg);
            _ = caller->respond(errorResponse);
        }
    }
}

public function addTokenServicesFilterAnnotation() {
    gateway:filterConfigAnnotationMap["authorizeService"] = gateway:getFilterConfigFromServiceAnnotation(reflect:getServiceAnnotations(authorizeService));
    gateway:filterConfigAnnotationMap["tokenService"] = gateway:getFilterConfigFromServiceAnnotation(reflect:getServiceAnnotations(tokenService));
    gateway:filterConfigAnnotationMap["revokeService"] = gateway:getFilterConfigFromServiceAnnotation(reflect:getServiceAnnotations(revokeService));
    gateway:filterConfigAnnotationMap["userInfoService"] = gateway:getFilterConfigFromServiceAnnotation(reflect:getServiceAnnotations(userInfoService));
}
