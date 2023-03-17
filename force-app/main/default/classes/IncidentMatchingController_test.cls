@istest

Public class IncidentMatchingController_test{


Public static testmethod void setupgrid(){

    test.starttest();
            
           Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
           Test_SetUpCaseProtocol_2.testCreateProtocol();
           
           List<Incident_Information__c> matchingIncidents = [SELECT Id, State_County__c, Postal_Code__c, Address_Line_1__c, City2__c, Country__c,  Incident_Matching_Date__c , Incident_Date__c, OwnerId, Description__c, Name from Incident_Information__c ];
        
          
           User[] user1 = [Select id From User where username='handler4@testINAP.com']; 
    
    
    
      matchingIncidents[0].OwnerId = user1[0].id;
      update matchingIncidents;                                  
   
    System.runAs(user1[0]) {
              IncidentMatchingController.getIncidents(matchingIncidents[0].Postal_Code__c, matchingIncidents[0].Incident_Matching_Date__c,''); 
          
    }
          
            
    test.stoptest();
    

}



}