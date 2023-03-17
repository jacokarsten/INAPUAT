Public Class Test_InsertProtocolOptions{



  public static void InsertProtocolOptions() {
        
        
        //Claimant
        Protocol_Option__c testProtocolOptionClaimantType1 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Claimant',
                                                                                     Protocol_Option__c = 'Claimant - PI-MV-EE'
        );
        insert testProtocolOptionClaimantType1;
        
        Protocol_Option__c testProtocolOptionClaimantType2 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Claimant',
                                                                                     Protocol_Option__c = 'Claimant - PI-MV-AO'
        );
        insert testProtocolOptionClaimantType2;
        
        Protocol_Option__c testProtocolOptionClaimantType3 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Claimant',
                                                                                     Protocol_Option__c = 'Claimant - PI-EL-EE'
        );
        insert testProtocolOptionClaimantType3;
        Protocol_Option__c testProtocolOptionClaimantType4 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Claimant',
                                                                                     Protocol_Option__c = 'Claimant - PI-PL-EE'
        );
        insert testProtocolOptionClaimantType4;
        
        
        
        
        
        //Defendant
        Protocol_Option__c testProtocolOptionDefendantType1 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Defendant',
                                                                         Protocol_Option__c = 'Defendant - PI-MV-EE'
        );
        insert testProtocolOptionDefendantType1;
        Protocol_Option__c testProtocolOptionDefendantType2 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Defendant',
                                                                         Protocol_Option__c = 'Defendant - PI-MV-AO'
        );
        insert testProtocolOptionDefendantType2;
        Protocol_Option__c testProtocolOptionDefendantType3 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Defendant',
                                                                         Protocol_Option__c = 'Defendant - PI-EL-EE'
        );
        insert testProtocolOptionDefendantType3;
        Protocol_Option__c testProtocolOptionDefendantType4 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Defendant',
                                                                         Protocol_Option__c = 'Defendant - PI-PL-EE'
        );
        insert testProtocolOptionDefendantType4;
        
        
        
        
        //Incident
        Protocol_Option__c testProtocolOptionIncidentType1 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Incident',
                                                                         Protocol_Option__c = 'Incident - PI-MV-EE'
        );
        insert testProtocolOptionIncidentType1;
        Protocol_Option__c testProtocolOptionIncidentType2 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Incident',
                                                                         Protocol_Option__c = 'Incident - PI-MV-AO'
        );
        insert testProtocolOptionIncidentType2;
        Protocol_Option__c testProtocolOptionIncidentType3 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Incident',
                                                                         Protocol_Option__c = 'Incident - PI-EL-EE'
        );
        insert testProtocolOptionIncidentType3;
        Protocol_Option__c testProtocolOptionIncidentType4 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Incident',
                                                                         Protocol_Option__c = 'Incident - PI-PL-EE'
        );
        insert testProtocolOptionIncidentType4;
         
        
        //Case
        
        Protocol_Option__c testProtocolOptionCaseType1 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Case',
                                                                         Protocol_Option__c = 'Case - PI-MV-EE'
        );
        Insert testProtocolOptionCaseType1;
        Protocol_Option__c testProtocolOptionCaseType2 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Case',
                                                                         Protocol_Option__c = 'Case - PI-MV-AO'
        );
        Insert testProtocolOptionCaseType2;
        Protocol_Option__c testProtocolOptionCaseType3 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Case',
                                                                         Protocol_Option__c = 'Case - PI-EL-EE'
        );
        Insert testProtocolOptionCaseType3;
        Protocol_Option__c testProtocolOptionCaseType4 = new  Protocol_Option__c (Protocol_Item_Type__c = 'Case',
                                                                         Protocol_Option__c = 'Case - PI-PL-EE'
        );
        Insert testProtocolOptionCaseType4;
        
        
 }
 
 
 }