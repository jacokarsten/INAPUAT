@istest

Public class CaseMatchingUtility_test{


Public static testmethod void CaseMatchingUtility1(){

    test.starttest();
        Test_InsertProtocolOptions.InsertProtocolOptions();
        Test_Staging_Matching.testCreateProtocol ();
        
        
        Test_Staging_Matching.SetUpAdminUser();
        
        Test_Staging_Matching.SetupMatching();
        
        Protocol__c[] testProtocol = [Select id from Protocol__c ]; 
        
        Case_Staging_Table__c[] CaseStagingTable = [Select id,Mapped_Protocol__c FROM Case_Staging_Table__c];
        
        CaseStagingTable[0].Mapped_Protocol__c = testProtocol[0].id;
        update CaseStagingTable;
        
        List<Id> ids = new List<Id>();
        
        for(Case_Staging_Table__c t:CaseStagingTable){
            ids.add(t.id);
        }
        
        
        CaseMatchingUtility.ProcessImportedData (ids);
        
    test.stoptest();
    

}



}