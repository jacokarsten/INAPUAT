Public class Test_Staging_Matching{


Public static void SetUpAdminUser(){
    
    
    //Insert Protocol
   Profile[]  lst_prof=[SELECT Id,Name FROM Profile where Name ='System Administrator'];
        
        User usersys = new User(alias = 'test123', email='test123@noemail.com',
                emailencodingkey='UTF-8', lastname='Testing2', languagelocalekey='en_US',
                localesidkey='en_US', profileid = lst_prof[0].id, IsActive =true,
                
                TimeZoneSidKey = 'Africa/Johannesburg', username='sys@noemail.com');
       
        insert usersys;



}

public static void testCreateProtocol () {
        
        List<Protocol_Option__c> lst_Option = new List<Protocol_Option__c>();
        
        Protocol_Option__c testProtocolOptionClaimantType = new  Protocol_Option__c (Protocol_Item_Type__c = 'Claimant',
                                                                                     Protocol_Option__c = 'Claimant - PI-MV-EE'
        );
        //insert testProtocolOptionClaimantType;
        lst_Option.add(testProtocolOptionClaimantType);
        
        Protocol_Option__c testProtocolOptionDefendantType = new  Protocol_Option__c (Protocol_Item_Type__c = 'Defendant',
                                                                         Protocol_Option__c = 'Defendant - PI-MV-EE'
        );
        
        //insert testProtocolOptionDefendantType;
        lst_Option.add(testProtocolOptionDefendantType);
        
        
        
        Protocol_Option__c testProtocolOptionIncidentType = new  Protocol_Option__c (Protocol_Item_Type__c = 'Incident',
                                                                         Protocol_Option__c = 'Incident - PI-MV-EE'
        );
        //insert testProtocolOptionIncidentType;
        lst_Option.add(testProtocolOptionIncidentType);
        
        
        Protocol_Option__c testProtocolOptionCaseType = new  Protocol_Option__c (Protocol_Item_Type__c = 'Case',
                                                                         Protocol_Option__c = 'Case - PI-MV-EE'
        );
        //insert testProtocolOptionCaseType;
        lst_Option.add(testProtocolOptionCaseType);
        
        Insert lst_Option;
        
        
        List<Protocol_Option__c> lst_OptionIns = new List<Protocol_Option__c>([Select Protocol_Option__c,Record_Type_ID__c,Protocol_Item_Type__c From  Protocol_Option__c ]);
        
        Map<String,String> Map_ProtOp = new Map<String,String>();
        Map<String,String> Map_ProtRec = new Map<String,String>();
        for(Protocol_Option__c opp:lst_OptionIns){
            Map_ProtOp.put(opp.Protocol_Item_Type__c,opp.id);
            Map_ProtRec.put(opp.Protocol_Item_Type__c,opp.Record_Type_ID__c);
            
        }
        system.debug('***PROTDEF***'+Map_ProtRec);
        
        Protocol__c testProtocol = new Protocol__c(Name = 'Test Protocol 1', 
                                                   Cap_on_Amount__c = 35000, 
                                                   CurrencyISOCode = 'GBP', 
                                                   Facilitator_Required__c = 'Yes',
                                                   Mininmum_Schedule__c = 'Merit and Damages Required',
                                                   Validations__c = 'None',
                                                   Code__c = 'Test-001',
                                                   Interest_Rate__c = 0,
                                                   No_referral_days__c = 0,
                                                   Bilateral_referral_days__c = 0,
                                                   Unilateral_referral_days__c = 0,
                                                   Bilateral_Prior_Notification_days__c = 0,
                                                   Unilateral_Prior_Notification_days__c = 0,
                                                   Doc_Prep_Duration__c = 1,
                                                   Doc_Prep_prior_Notification_days__c = 0,
                                                   Arbitrator_Notification_No_of_Days__c = 0,
                                                   Market_Maker_Notification_No_of_Days__c = 0,
                                                   Final_Offers_Duration__c = 1,
                                                   Final_Offer_prior_Notification_days__c = 0,
                                                   Claimant_Type__c = Map_ProtOp.get('Claimant'), //testProtocolOptionClaimantType.Id,
                                                   Defendant_type__c =  Map_ProtOp.get('Defendant'), //testProtocolOptionDefendantType.Id,
                                                   Incident_Type__c =  Map_ProtOp.get('Incident'), //testProtocolOptionIncidentType.Id,
                                                   Case_Type__c =  Map_ProtOp.get('Case') //testProtocolOptionCaseType.Id
                                                  );
        insert testProtocol;
        
        
        
        
}






public Static void SetupMatching(){
    
    //Insert Protocol
    
    
    Case_Staging_Table__c Staging = new Case_Staging_Table__c();
    
    date dob = Date.newInstance(1980,10,10);

    Staging.Address_Line_1__c = '';
    Staging.Address_Line_2__c = '';
   // Staging.Case__c= '';
    Staging.Case_Number__c= '123';
    Staging.Case_Source__c= 'Claimant';
    Staging.Claimant_Date_of_Birth__c= dob;
    Staging.Claimant_Firm_ID__c= '111';
    Staging.Claimant_Firm_Name__c= 'Claimant';
    Staging.Claimant_First_Name__c= 'Claimant';
    Staging.Claimant_Last_Name__c= 'Claimant';
    Staging.Claimant_Reference_Number__c= '1245888';
    Staging.Claimant_Vehicle_Registration_Number__c= '224444';
    Staging.Defendant_Date_of_Birth__c= dob;
    Staging.Defendant_Firm_ID__c= 'Defendant';
    Staging.Defendant_Firm_Name__c= 'Defendant';
    Staging.Defendant_First_Name__c= 'Defendant';
    Staging.Defendant_Last_Name__c= 'Defendant';
    Staging.Defendant_Vehicle_Registration_Number__c= '22444';
    Staging.Firm_Team__c= 'Team1';
    Staging.Import_Errors__c = '';   
  //  Staging.Import_Key__c= '';
    Staging.Incident_City__c= 'London';
    Staging.Incident_Country__c= 'UK';
    Staging.Incident_Date__c= dob;
    Staging.Incident_Description__c= 'hit and run';
    Staging.Incident_Post_Code__c= 'rh56 ty6';
   // Staging.Incident_Post_Code_Shorten__c= '';
    Staging.Incident_Street__c= 'Long';
   // Staging.Mapped_Claimant_Firm__c= '';
   // Staging.Mapped_Defendant_Firm__c= '';
   // Staging.Mapped_Firm_Team__c= '';
   // Staging.Mapped_Incident__c= '';
    Staging.Mapped_Incident_Count__c= 2;
    //Staging.Mapped_Protocol__c= '';
    Staging.Mapped_Status__c= '';
    Staging.Mapped_Status_Detail__c= '';
    Staging.Merit_Claimant_Position__c= 80;
    Staging.Protocol_Code__c= '';
    //Staging.Related_New_Case__c= '';
   // Staging.Validate_and_Insert__c= '';
    
    Insert Staging;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


}