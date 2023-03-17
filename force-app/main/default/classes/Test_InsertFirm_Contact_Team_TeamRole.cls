Public Class Test_InsertFirm_Contact_Team_TeamRole{


  public static void testCreateAccount () {
        
        RecordType[] FirmRT = [Select id From RecordType where SobjectType='Account' AND DeveloperName='Representative_Firm'];
        
        Account testAccount = new Account(Name = 'Legalsmiths',RecordTypeId=FirmRT[0].id, 
                                          Sub_Type__c = 'Legal',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        insert testAccount; 
        Firm_Team__c testFirmTeam = new Firm_Team__c(Name = testAccount.Name +'Team1', 
                                                     Firm__c = testAccount.Id );
        insert testFirmTeam;
        testCreateContact (testAccount.Id, 'Handler', Account.Name+ '1', testFirmTeam.Id);
    }
    
   public static void testCreateContact (String AccountId, String Type, String LastName, String FirmTeam) {
        
        List<Contact> lstCon = new List<Contact>();
        
        Contact testContact = new Contact(FirstName = 'James', 
                                          LastName = LastName, 
                                          CurrencyISOCode = 'GBP',
                                          email='test13@noemail.com', 
                                          Status__c = 'Active', 
                                          Role__c = Type, 
                                          AccountId = AccountId );
        lstCon.Add(testContact);
        Contact testContact2 = new Contact(FirstName = 'James', 
                                          LastName = LastName, 
                                          CurrencyISOCode = 'GBP',
                                          email='test129@noemail.com', 
                                          Status__c = 'Active', 
                                          Role__c = Type, 
                                          AccountId = AccountId );
        lstCon.add(testContact2);
        Insert lstCon;
        
        List<Firm_Team_Roles__c> lstRoles = new List<Firm_Team_Roles__c>();
         
        Firm_Team_Roles__c testFirmTeamRole1 = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = FirmTeam, 
                                                                     Contact__c = lstCon[0].Id 
                                                                    );
        lstRoles.add(testFirmTeamRole1);
        
        Firm_Team_Roles__c testFirmTeamRole2 = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = FirmTeam, 
                                                                     Contact__c =lstCon[1].Id 
                                                                    );
        lstRoles.add(testFirmTeamRole2);
        Insert lstRoles;
        
    }
    



Public static void insertContactUser(String srcUserName,String srcAlias){
        
        RecordType[] FirmRT = [Select id From RecordType where SobjectType='Account' AND DeveloperName='Representative_Firm'];
        
        List<Account> Lst_Account = new List<Account>();
        Account testAccount = new Account(Name = 'Legalsmiths',RecordTypeId=FirmRT[0].id, 
                                          Sub_Type__c = 'Legal',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
         Lst_Account.Add(testAccount);    
                                      
       Insert Lst_Account;
        
        List<Firm_Team__c> lst_FirmTeam = new List<Firm_Team__c>();
        Firm_Team__c testFirmTeam = new Firm_Team__c(Name = testAccount.Name +'Team 1',Status__c = 'Inactive', 
                                                     Firm__c = Lst_Account[0].Id );
        lst_FirmTeam.Add(testFirmTeam);
        
       insert lst_FirmTeam;

        Profile[] lst_prof=[SELECT Id,Name FROM Profile where Name ='INAP Community Case Handler'];

  
        List<Contact> lstCon = new List<Contact>();
        Contact HContact = new Contact(FirstName = 'James', 
                                          LastName = testAccount.name+'H', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test128@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[0].Id );
        Contact HContact2 = new Contact(FirstName = 'James2', 
                                          LastName = testAccount.name+'H2', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test127@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[0].Id);                                  
        lstCon.add(HContact);
        lstCon.add(HContact2);
        
        Contact SContact = new Contact(FirstName = 'James', 
                                          LastName = testAccount.name+'S', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='supervisor2@inap.com', 
                                          Role__c = 'Supervisor', 
                                          AccountId = Lst_Account[0].Id);
        lstCon.add(SContact);
        
       
        
        insert lstCon; 
         
        List<User> lstUsr = new List<User>();
                  
        
                  
        User user1 = new User(alias = 'SRCH', email='handler1@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[0].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler1@testINAP.com');
       
        lstUsr.add(user1);
        User user1H = new User(alias = 'SRCHX', email='handler2@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[1].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler2@testINAP.com');
       
        lstUsr.add(user1H);
        
        User user2 = new User(alias = 'srcSup', email='supervisor1@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[2].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='supervisor1@testINAP.com');
                
       
        lstUsr.add(user2);
        
        insert lstUsr;
        
        
         
        List<Firm_Team_Roles__c> lstFirmTeamRoles = new List<Firm_Team_Roles__c>();
        
        Firm_Team_Roles__c testFirmTeamRole = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = lst_FirmTeam[0].id, 
                                                                     Contact__c = lstCon[0].Id
                                                                      );
        Firm_Team_Roles__c testFirmTeamRole2 = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = lst_FirmTeam[0].id, 
                                                                     Contact__c = lstCon[1].Id
                                                                      );
                                                                                                                                    
        lstFirmTeamRoles.Add(testFirmTeamRole);
        lstFirmTeamRoles.Add(testFirmTeamRole2); 
        
        insert lstFirmTeamRoles;
        
        
        testFirmTeam.Status__c='Active';
        Update testFirmTeam;
        
        
        lst_prof=[SELECT Id,Name FROM Profile where Name ='System Administrator'];
        
        User usersys = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing2', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                
                TimeZoneSidKey = 'Africa/Johannesburg', username='sys@noemail.com');
       
        insert usersys;
        

}



 Public static void insertContactUser2(){
        
        RecordType[] FirmRT = [Select id From RecordType where SobjectType='Account' AND DeveloperName='Representative_Firm'];
        
        List<Account> Lst_Account = new List<Account>();
        Account testAccount = new Account(Name = 'Insuresmiths',RecordTypeId=FirmRT[0].id, 
                                          Sub_Type__c = 'Legal',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        
        Lst_Account.Add(testAccount);
        
       Account testAccount1 = new Account(Name = 'Legalsmiths',RecordTypeId=FirmRT[0].id, 
                                          Sub_Type__c = 'Legal',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );                                  
        Lst_Account.Add(testAccount1);
 
        
       Insert Lst_Account;
       
       
       
        
        List<Firm_Team__c> lst_FirmTeam = new List<Firm_Team__c>(); 
        Firm_Team__c testFirmTeam = new Firm_Team__c(Name = testAccount.Name +'Team 1',Status__c = 'Inactive', 
                                                     Firm__c = Lst_Account[0].Id );
         lst_FirmTeam.Add(testFirmTeam);

         Firm_Team__c testFirmTeam2 = new Firm_Team__c(Name = testAccount.Name +'Team1', 
                                                     Firm__c = Lst_Account[1].Id );
        lst_FirmTeam.Add(testFirmTeam2);        
        Insert lst_FirmTeam;
        
        
        
        Profile[] lst_prof=[SELECT Id,Name FROM Profile where Name ='INAP Community Case Handler'];

        List<Contact> lstCon = new List<Contact>();
        Contact HContact = new Contact(FirstName = 'James', 
                                          LastName = testAccount.name+'H', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test126@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[0].Id );
                                          
        Contact HContact2 = new Contact(FirstName = 'James2', 
                                          LastName = testAccount.name+'H2', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          email='test125@noemail.com',
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[0].Id);                                  
        lstCon.add(HContact);
        lstCon.add(HContact2);
        
        Contact SContact = new Contact(FirstName = 'James', 
                                          LastName = testAccount.name+'S', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          email='supervisor1@inap.com',
                                          Role__c = 'Supervisor', 
                                          AccountId = Lst_Account[0].Id );
        lstCon.add(SContact);
        
        
         Contact testContact = new Contact(FirstName = 'James', 
                                          LastName = testAccount1.name+'X', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test122@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[1].Id );
        lstCon.Add(testContact);
        Contact testContact2 = new Contact(FirstName = 'James', 
                                          LastName = testAccount1.name+'Y', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test121@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[1].Id);
        lstCon.add(testContact2);
        Contact SContact2 = new Contact(FirstName = 'James', 
                                          LastName = testAccount.name+'Z', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          email='supervisor2@inap.com',
                                          Role__c = 'Supervisor', 
                                          AccountId = Lst_Account[1].Id );
        lstCon.add(SContact2);
        
        
        insert lstCon; 
        
         List<User> lstUsr = new List<User>();          
        User user1 = new User(alias = 'SRCH', email='handler1@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[0].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler3@testINAP.com');
       
        lstUsr.add(user1);
        User user1H = new User(alias = 'SRCHX', email='handler2@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[1].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler4@testINAP.com');
       
        lstUsr.add(user1H);
        
        User user2 = new User(alias = 'srcSup', email='supervisor@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[2].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='supervisor2@testINAP.com');
       
        lstUsr.add(user2);
        
        
        User user3 = new User(alias = 'SRCH', email='handler3@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[3].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler5@testINAP.com');
       
        lstUsr.add(user3);
        User user4 = new User(alias = 'SRCHX', email='handler3@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[4].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler6@testINAP.com');
       
        lstUsr.add(user4);
        
        User user5 = new User(alias = 'srcSup', email='supervisor7@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = lstCon[5].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='supervisor7@testINAP.com');
       
        lstUsr.add(user5);
        
        
        
        insert lstUsr;
        
         

        List<Firm_Team_Roles__c> lstFirmTeamRoles = new List<Firm_Team_Roles__c>();
        
        Firm_Team_Roles__c testFirmTeamRole = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = lst_FirmTeam[0].id, 
                                                                     Contact__c = lstCon[0].Id
                                                                      );
        Firm_Team_Roles__c testFirmTeamRole2 = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = lst_FirmTeam[0].id, 
                                                                     Contact__c = lstCon[1].Id
                                                                      );
                                                                                                                                    
        lstFirmTeamRoles.Add(testFirmTeamRole);
        lstFirmTeamRoles.Add(testFirmTeamRole2); 
        
        
        Firm_Team_Roles__c testFirmTeamRole3 = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = lst_FirmTeam[1].id, 
                                                                     Contact__c = lstCon[3].Id
                                                                      );
        Firm_Team_Roles__c testFirmTeamRole4 = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = lst_FirmTeam[1].id, 
                                                                     Contact__c = lstCon[4].Id
                                                                      );
                                                                                                                                    
        lstFirmTeamRoles.Add(testFirmTeamRole3);
        lstFirmTeamRoles.Add(testFirmTeamRole4);
        
        insert lstFirmTeamRoles;
        
        lst_FirmTeam[0].Status__c='Active';
        lst_FirmTeam[1].Status__c='Active';
        Update lst_FirmTeam;
        
        
        

}

Public static void insertContactUser3(){
        
        RecordType[] FirmRT = [Select id From RecordType where SobjectType='Account' AND DeveloperName='Service_Firm'];
        
        Account testAccount = new Account(Name = 'Facilitate',RecordTypeId=FirmRT[0].id, 
                                          Sub_Type__c = 'Facilitation',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        insert testAccount; 
        
        Profile[] lst_prof=[SELECT Id,Name FROM Profile where Name ='INAP Community Facilitator'];

  
       
        Contact testContact = new Contact(FirstName = 'James', 
                                          LastName = testAccount.name, 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          Role__c = 'Facilitator',
                                          email='test123@noemail.com', 
                                          AccountId = testAccount.Id );
        insert testContact; 
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = testContact.Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='facilitate@noemail.com');
       
        insert user;
        system.runAs(user) {
            // statements to be executed by this test user.
        }


       
        
        
        
        

}

Public static void insertContactUser4(){
        
        RecordType[] FirmRT = [Select id From RecordType where SobjectType='Account' AND DeveloperName='Service_Firm'];
        
        Account testAccount = new Account(Name = 'Arbitrator',RecordTypeId=FirmRT[0].id, 
                                          Sub_Type__c = 'Arbitration',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        insert testAccount; 
        

        Profile[] lst_prof=[SELECT Id,Name FROM Profile where Name ='INAP Community Arbitrator'];

  
       
        Contact testContact = new Contact(FirstName = 'James', 
                                          LastName = testAccount.name, 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test123@noemail.com', 
                                          Role__c = 'Arbitrator', 
                                          AccountId = testAccount.Id );
        insert testContact; 
                  
        User user = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                ContactId = testContact.Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='Arbitrate@noemail.com');
       
        insert user;
        system.runAs(user) {
            // statements to be executed by this test user.
        }


      
        
        
        
        

}




}