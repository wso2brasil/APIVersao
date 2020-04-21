
function getOpenAPIs() returns map<json> {
	return {  "Versao_API__1_0_0" : {
  "openapi" : "3.0.0",
  "info" : {
    "title" : "Versao API",
    "license" : {
      "name" : "MIT"
    },
    "version" : "1.0.0"
  },
  "servers" : [ {
    "url" : "http://host.docker.internal:49090/"
  } ],
  "paths" : {
    "/versao" : {
      "get" : {
        "tags" : [ "etcd" ],
        "summary" : "Recuperar a versao da API",
        "operationId" : "recuperar a versao da API",
        "responses" : {
          "200" : {
            "description" : "um json com a versao da API"
          }
        },
        "extensions" : {
          "x-wso2-production-endpoints" : {
            "urls" : [ "etcd (versao_endpoint, http://host.docker.internal:19090)" ]
          }
        }
      }
    }
  },
  "extensions" : {
    "x-wso2-basePath" : "/",
    "x-wso2-production-endpoints" : {
      "urls" : [ "http://host.docker.internal:39090" ]
    }
  }
}  };
}