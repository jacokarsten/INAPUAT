@istest

Public class UserAccessRights_test{

 
Public static testmethod void UserAccessRights1(){

    test.starttest();
    
            
           // Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
          //  Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
           Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();
            
            Test_SetUpCaseProtocol_3.testCreateProtocol();
   
    User[] user1 = [Select id From User where username='handler4@testINAP.com']; 
    
    
    Case cs = [Select id from Case limit 1];
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
    
    
    user1 = [Select id From User where username='handler3@testINAP.com']; 
  
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
    
    
    

}

Public static testmethod void UserAccessRights2(){

    test.starttest();
    
      //      Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
      //      Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
      //      Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
      Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();
            
      Test_SetUpCaseProtocol_3.testCreateProtocol();
   
    User[] user1 = [Select id From User where username='handler4@testINAP.com']; 
    
    
    Case cs = [Select id from Case limit 1];
  
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
      
      
    user1 = [Select id From User where username='supervisor2@testINAP.com']; 
  
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
     
    UserAccessRights.UserRightsLossItems(cs.Id);
    test.stoptest();
    

} 

Public static testmethod void UserAccessRights2b(){

    test.starttest();
    
             
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
       //     Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
         Test_InsertFirm_Contact_Team_TeamRole_2.insertContactUser();   
            Test_SetUpCaseProtocol_3.testCreateProtocol();
   
    User[] user1 = [Select id From User where username='handler5@testINAP.com']; 
    
    
    Case cs = [Select id from Case limit 1];
  
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
      
      
    user1 = [Select id From User where username='supervisor7@testINAP.com']; 
  
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
     
    UserAccessRights.UserRightsLossItems(cs.Id);
    test.stoptest();
    

}



 
Public static testmethod void UserAccessRights4(){

    test.starttest();
    
           
        //    Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser3();
            
            
            
            Test_SetUpCaseProtocol_1.testCreateProtocol();
   
     
        
    Case cs = [Select id,Facilitator_Firm__c,Facilitator_Contact__c from Case limit 1];
  
       
    Contact[] Facilitator = [Select id from Contact where Role__c = 'Facilitator'];            
       
                     
    cs.Facilitator_Contact__c = Facilitator[0].id;           
    update cs;
     
     
    User[] user1 = [Select id From User where username='facilitate@noemail.com']; 
    
    
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
     
    
    test.stoptest();
    

} 
 
Public static testmethod void UserAccessRights3(){

    test.starttest();
    
            
         //   Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
            
            
            Test_InsertFirm_Contact_Team_TeamRole.insertContactUser4();
            
            
            Test_SetUpCaseProtocol_1a.testCreateProtocol();
   
     
     
        
    Case cs = [Select id,Invite_Arbitrator__c,Arbitrator_Contact__c from Case limit 1];
  
       
           
            
    Contact[] Arbitrator = [Select id from Contact where Role__c = 'Arbitrator'];
     cs.Invite_Arbitrator__c = true;                 
     cs.Arbitrator_Contact__c = Arbitrator[0].id;            
           
    cs.Arbitrator_Accept_Decline__c='Accept';
            
    update cs;  
            
    User[] user1 = [Select id From User where username='Arbitrate@noemail.com'];
    System.runAs(user1[0]) {
              UserAccessRights.UserRightsLossItems(cs.Id);
    }
      
      
   
     
    
    test.stoptest();
    

}
 

}