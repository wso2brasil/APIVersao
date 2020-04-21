
public function main() {
    
    string[] Versao_API__1_0_0_service = [ "get_bb701c4f_d224_417a_baaa_dd836f7d4c37"
                                ];
    gateway:populateAnnotationMaps("Versao_API__1_0_0", Versao_API__1_0_0, Versao_API__1_0_0_service);
    
    addTokenServicesFilterAnnotation();

    initThrottlePolicies();

    map<string> receivedRevokedTokenMap = gateway:getRevokedTokenMap();
    boolean jmsListenerStarted = gateway:initiateTokenRevocationJmsListener();

    boolean useDefault = gateway:getConfigBooleanValue(gateway:PERSISTENT_MESSAGE_INSTANCE_ID,
    gateway:PERSISTENT_USE_DEFAULT, false);

    if (useDefault){
        future<()> initETCDRetriveal = start gateway:etcdRevokedTokenRetrieverTask();
    } else {
        initiatePersistentRevokedTokenRetrieval(receivedRevokedTokenMap);
    }
    startupExtension();
}
