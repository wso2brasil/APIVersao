import ballerina/http;
import ballerina/log;
import ballerina/docker;
@docker:Expose {}
listener http:Listener helloWorldEP = new(9090);
@docker:Config {
    name: "livetraining",
    tag: "1.0.1"
}
@http:ServiceConfig {
    basePath: "/"
}
service livetraining on helloWorldEP {
    resource function versao(http:Caller outboundEP, http:Request request) {
        http:Response response = new;
        response.setTextPayload("WSO2 Live Training (Português) - API Manager! versao 1.0.1 \n");
        var responseResult = outboundEP->respond(response);
        if (responseResult is error) {
            error err = responseResult;
            log:printError("Error sending response", err);
        }
    }
}
