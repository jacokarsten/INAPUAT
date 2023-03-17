Public class TestDateghostDraft{


Public static void Setup(){


            Ghost_Draft_API__c Ghost_Draft_API = new Ghost_Draft_API__c();
            
            Ghost_Draft_API.Commencement_URL__c='https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Arbitral%20Award&Format=pdf';
            
            Ghost_Draft_API.Final_Award_URL__c='https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Settlement%20Agreement&Format=pdf';    
            
            Ghost_Draft_API.Interim_Award_URL__c='https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Notice%20of%20Commencement%20of%20Arbitration&Format=pdf';
            
            Ghost_Draft_API.Settlement_URL__c='https://secure.ghostdraft.com/instances/GhostDraft/GhostDraftServer/RestApi/AssembleDocument?DocumentServiceName=INAP&PackageName=INAP&PackageVersion=1.2&TemplateName=Interim%20Arbitral%20Award&Format=pdf';
            insert Ghost_Draft_API;

}



}