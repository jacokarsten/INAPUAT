Public Class Test_InsertFirm_Contact_Team_TeamRole_2{



 Public static void insertContactUser(){
        
        RecordType[] FirmRTRep = [Select id From RecordType where SobjectType='Account' AND DeveloperName='Representative_Firm'];
        RecordType[] FirmRTServ = [Select id From RecordType where SobjectType='Account' AND DeveloperName='Service_Firm'];
        
        List<Account> Lst_Account = new List<Account>();
        Account AccountInsure0 = new Account(Name = 'Insuresmiths',RecordTypeId=FirmRTRep[0].id, 
                                          Sub_Type__c = 'Legal',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        
        Lst_Account.Add(AccountInsure0);
        
       Account AccountLegal1 = new Account(Name = 'Legalsmiths',RecordTypeId=FirmRTRep[0].id, 
                                          Sub_Type__c = 'Legal',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );                                  
        Lst_Account.Add(AccountLegal1);
 
        
        Account AccountFacilitate2 = new Account(Name = 'Facilitate',RecordTypeId=FirmRTServ[0].id, 
                                          Sub_Type__c = 'Facilitation',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        Lst_Account.Add(AccountFacilitate2);
        
        Account AccountArb3 = new Account(Name = 'Arbitrator',RecordTypeId=FirmRTServ[0].id, 
                                          Sub_Type__c = 'Arbitration',Status__c='Active', 
                                          Firm_Supervisor_Email__c = 'Arbitrator@inap.com' );
       Lst_Account.Add(AccountArb3);
        
       Insert Lst_Account;
       
       
       
        
        List<Firm_Team__c> lst_FirmTeam = new List<Firm_Team__c>(); 
        Firm_Team__c testFirmTeam = new Firm_Team__c(Name = Lst_Account[0].Name +'Team 1',Status__c = 'Inactive', 
                                                     Firm__c = Lst_Account[0].Id );
         lst_FirmTeam.Add(testFirmTeam);

         Firm_Team__c testFirmTeam2 = new Firm_Team__c(Name = Lst_Account[0].Name +'Team1', 
                                                     Firm__c = Lst_Account[1].Id );
        lst_FirmTeam.Add(testFirmTeam2);        
        Insert lst_FirmTeam;
        
        
        
        Profile[] lst_profHand=[SELECT Id,Name FROM Profile where Name ='INAP Community Case Handler'];
        Profile[] lst_profSup=[SELECT Id,Name FROM Profile where Name ='INAP Community Supervisor'];
        Profile[] lst_profFac=[SELECT Id,Name FROM Profile where Name ='INAP Community Facilitator'];
        Profile[] lst_profArb=[SELECT Id,Name FROM Profile where Name ='INAP Community Arbitrator'];
        
        
        
        List<Contact> lstCon = new List<Contact>();
        Contact HanContact0 = new Contact(FirstName = 'James', 
                                          LastName = Lst_Account[0].name+'H', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test126@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[0].Id );
                                          
        Contact HanContact1 = new Contact(FirstName = 'James2', 
                                          LastName = Lst_Account[0].name+'H2', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          email='test125@noemail.com',
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[0].Id);                                  
        lstCon.add(HanContact0);
        lstCon.add(HanContact1);
        
        Contact SupContact2 = new Contact(FirstName = 'James', 
                                          LastName = Lst_Account[0].name+'S', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          email='supervisor1@inap.com',
                                          Role__c = 'Supervisor', 
                                          AccountId = Lst_Account[0].Id );
         lstCon.add(SupContact2);
        
        
         Contact HanContact3 = new Contact(FirstName = 'James', 
                                          LastName = Lst_Account[0].name+'X', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test122@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[1].Id );
        lstCon.Add(HanContact3);
        Contact HanContact4 = new Contact(FirstName = 'James', 
                                          LastName = Lst_Account[0].name+'Y', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test121@noemail.com', 
                                          Role__c = 'Handler', 
                                          AccountId = Lst_Account[1].Id);
        lstCon.add(HanContact4);
        Contact SupContact5 = new Contact(FirstName = 'James', 
                                          LastName = Lst_Account[0].name+'Z', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          email='supervisor2@inap.com',
                                          Role__c = 'Supervisor', 
                                          AccountId = Lst_Account[1].Id );
        lstCon.add(SupContact5);
        
       Contact FacContact6 = new Contact(FirstName = 'James', 
                                          LastName = Lst_Account[0].name+'Fac', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          Role__c = 'Facilitator',
                                          email='test123@noemail.com', 
                                          AccountId = Lst_Account[2].Id );
        
        lstCon.add(FacContact6); 
        
        Contact ArbContact7 = new Contact(FirstName = 'James', 
                                          LastName = Lst_Account[0].name+'Arb', 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active',
                                          email='test123@noemail.com', 
                                          Role__c = 'Arbitrator', 
                                          AccountId = Lst_Account[3].Id );
        lstCon.add(ArbContact7); 
                  
       
        
                         
        insert lstCon; 
        
        
         List<User> lstUsr = new List<User>();          
        User user1 = new User(alias = 'SRCH', email='handler1@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profHand[0].id, IsActive =true,
                ContactId = lstCon[0].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler3@testINAP.com');
       
        lstUsr.add(user1);
        User user1H = new User(alias = 'SRCHX', email='handler2@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profHand[0].id, IsActive =true,
                ContactId = lstCon[1].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler4@testINAP.com');
       
        lstUsr.add(user1H);
        
        User user2 = new User(alias = 'srcSup', email='supervisor@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profSup[0].id, IsActive =true,
                ContactId = lstCon[2].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='supervisor2@testINAP.com');
       
        lstUsr.add(user2);
        
        
        User user3 = new User(alias = 'SRCH', email='handler3@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profHand[0].id, IsActive =true,
                ContactId = lstCon[3].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler5@testINAP.com');
       
        lstUsr.add(user3);
        User user4 = new User(alias = 'SRCHX', email='handler3@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profHand[0].id, IsActive =true,
                ContactId = lstCon[4].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='handler6@testINAP.com');
       
        lstUsr.add(user4);
        
        User user5 = new User(alias = 'srcSup', email='supervisor7@testINAP.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profSup[0].id, IsActive =true,
                ContactId = lstCon[5].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='supervisor7@testINAP.com');
       
        lstUsr.add(user5);
        
        User user6 = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profFac[0].id, IsActive =true,
                ContactId = lstCon[6].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='facilitate@noemail.com');
       
        
         User user7 = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_profArb[0].id, IsActive =true,
                ContactId = lstCon[7].Id,
                TimeZoneSidKey = 'Africa/Johannesburg', username='Arbitrate@noemail.com');
       
        lstUsr.add(user7);
        
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







}