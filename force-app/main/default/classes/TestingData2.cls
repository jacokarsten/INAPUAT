@Istest
public class TestingData2 {

   public static void testCreateAccount () {
        Account testAccount = new Account(Name = 'Legalsmiths', 
                                          Sub_Type__c = 'Legal', 
                                          Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        insert testAccount; 
        Firm_Team__c testFirmTeam = new Firm_Team__c(Name = testAccount.Name +'Team 1', 
                                                     Firm__c = testAccount.Id );
        insert testFirmTeam;
        testCreateContact (testAccount.Id, 'Handler', Account.Name+ '1', testFirmTeam.Id);
    }
    
     public static void testCreateContact (String AccountId, String Type, String LastName, String FirmTeam) {
        Contact testContact = new Contact(FirstName = 'James', 
                                          LastName = LastName, 
                                          CurrencyISOCode = 'GBP', 
                                          Status__c = 'Active', 
                                          Role__c = Type, 
                                          AccountId = AccountId );
        insert testContact;
        Firm_Team_Roles__c testFirmTeamRole = new Firm_Team_Roles__c(Roles__c = 'Case Handler', 
                                                                     Firm_Team__c = FirmTeam, 
                                                                     Contact__c = testContact.Id 
                                                                     );
        insert testFirmTeamRole;
    }
    
   @testSetup  public static void testCreateProtocol () {
        
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
                                                   Doc_Prep_Duration__c = 0,
                                                   Doc_Prep_prior_Notification_days__c = 0,
                                                   Arbitrator_Notification_No_of_Days__c = 0,
                                                   Market_Maker_Notification_No_of_Days__c = 0,
                                                   Final_Offers_Duration__c = 0,
                                                   Final_Offer_prior_Notification_days__c = 0,
                                                   Claimant_Type__c = Map_ProtOp.get('Claimant'), //testProtocolOptionClaimantType.Id,
                                                   Defendant_type__c =  Map_ProtOp.get('Defendant'), //testProtocolOptionDefendantType.Id,
                                                   Incident_Type__c =  Map_ProtOp.get('Incident'), //testProtocolOptionIncidentType.Id,
                                                   Case_Type__c =  Map_ProtOp.get('Case') //testProtocolOptionCaseType.Id
                                                  );
        insert testProtocol;
        
        
        
        testCreateCase (testProtocol.Id, Map_ProtRec.get('Claimant'), Map_ProtRec.get('Defendant'), Map_ProtRec.get('Incident'),
                       Map_ProtRec.get('Case'), testProtocol.Name);
    }
    
    public static void testCreateCase (String ProtocolId, String ClaimantRecordTypeId, String DefendantRecordTypeId, String IncidentRecordTypeId, String CaseRecordTypeId, String ProtocolName) {
        Datetime myDate = Datetime.newInstance(2019, 4, 15, 12, 30, 2);
        Incident_Information__c testIncident = new  Incident_Information__c (Address_Line_1__c = 'Case',
                                                                                        Address_Line_2__c = 'Case - PI-MV-EE',
                                                                                        City__c = 'London',
                                                                                        Country__c = 'United Kingdom',
                                                                                        Description__c = 'High speed motor accident involving a bus and car',
                                                                                        Incident_Date__c = myDate,
                                                                                        Incident_Type__c = 'Motor Vehicle Accident',
                                                                                        Postal_Code__c = 'NW11 7HB'
        );
        insert testIncident;
        Case testCase = new Case (Case_Source__c = 'Claimant',
                                  Incident_Information__c = testIncident.Id,
                                  Origin = 'Manual',
                                  Protocol__c = ProtocolId,
                                  Type = ProtocolName
        );
        insert testCase;
        
        System.debug('**REC_ID**'+DefendantRecordTypeId);
        Defendant_Information__c testDefendantPerson = new Defendant_Information__c (Case__c = testCase.Id,
                                                                                     RecordTypeId = DefendantRecordTypeId
        );
        insert testDefendantPerson;
        
        Claimant_Information__c testClaimantPerson = new Claimant_Information__c (Case__c = testCase.Id,
                                                                                  RecordTypeId = ClaimantRecordTypeId
        );
        insert testClaimantPerson;
        Schedule_of_Losses__c testSOL = new Schedule_of_Losses__c (Case__c = testCase.Id,
                                                                   Claimant_Information__c = testClaimantPerson.Id
        );
        insert testSOL;
        Defendant_Firm__c testDefendantFirm = new Defendant_Firm__c (Case__c = testCase.Id
        );
        insert testDefendantFirm;
        Merit__c testMerit = new Merit__c (Related_Case__c = testCase.Id,
                                           Schedule_of_Losses__c = testSOL.Id,
                                           Name = 'Defendant Liability'
        );
        insert testMerit;
        Loss_Category__c testPFL = new Loss_Category__c (Case__c = testCase.Id,
                                                         Schedule_of_Losses__c = testSOL.Id,
                                                         Head_of_Loss_Type__c = 'Past Financial Losses'
        );
        insert testPFL;
        Loss_Category__c testPSLA = new Loss_Category__c (Case__c = testCase.Id,
                                                         Schedule_of_Losses__c = testSOL.Id,
                                                         Head_of_Loss_Type__c = 'Personal Injury and Loss of Amenity'
        );
        insert testPSLA;
        Loss_Category__c testFFL = new Loss_Category__c (Case__c = testCase.Id,
                                                         Schedule_of_Losses__c = testSOL.Id,
                                                         Head_of_Loss_Type__c = 'Future Financial Losses'
        );
        insert testFFL;
        Loss_Category__c testCongenialEmployment = new Loss_Category__c (Case__c = testCase.Id,
                                                         Schedule_of_Losses__c = testSOL.Id,
                                                         Head_of_Loss_Type__c = 'Loss of Congenial Employment'
        );
        insert testCongenialEmployment;
        Loss_Category__c testDisadvantageLabourMarket = new Loss_Category__c (Case__c = testCase.Id,
                                                         Schedule_of_Losses__c = testSOL.Id,
                                                         Head_of_Loss_Type__c = 'Disadvantage on Labour Market'
        );
        insert testDisadvantageLabourMarket;
        Loss_Category__c testBereavement = new Loss_Category__c (Case__c = testCase.Id,
                                                         Schedule_of_Losses__c = testSOL.Id,
                                                         Head_of_Loss_Type__c = 'Bereavement'
        );
        insert testBereavement;
        Loss_Category__c testLegalCosts = new Loss_Category__c (Case__c = testCase.Id,
                                                         Schedule_of_Losses__c = testSOL.Id,
                                                         Head_of_Loss_Type__c = 'Legal Costs'
        );
        insert testLegalCosts;
    }
    
    
}