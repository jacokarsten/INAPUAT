public class TestingData {
    
    public static void testAccount () {
        Account testAccount = new Account(Name = 'Legalsmiths', Sub_Type__c = 'Legal', Firm_Supervisor_Email__c = 'supervisor@inap.com' );
        insert testAccount; 
    }
    
    public static void testAccountBulk() {
        List<Account> accList = new List<Account>();
        for (Integer i=0;i<10;i++)
        {
            Account testAccount = new Account();
            testAccount.Name='LegalS'+i;
            testAccount.Sub_Type__c='Legal';
            testAccount.Firm_Supervisor_Email__c= 'supervisor'+i+'@inap.com';
            accList.add(testAccount);
        }
        insert accList;
    }
    
    public static void testContact (String AccountId, String Type, String LastName) {
        Contact testContact = new Contact(FirstName = 'James', LastName = LastName, CurrencyISOCode = 'GBP', Status__c = 'Active', Role__c = Type, AccountId = AccountId );
        insert testContact;
    }
    
    public static void testContactBulk() {
        List<Contact> conList = new List<Contact>();
        List<Account> accList = new List<Account>();
        for (Integer i=0;i<10;i++)
        {
            Account testAccount = new Account();
            testAccount.Name='LegalS'+i;
            testAccount.Sub_Type__c='Legal';
            testAccount.Firm_Supervisor_Email__c= 'supervisor'+i+'@inap.com';
            accList.add(testAccount);
        }
        insert accList;
        for (Account acc:accList)
            for (Integer i=0;i<5;i++)
        {
            Contact testContact = new Contact();
            testContact.FirstName ='James'+i;
            testContact.LastName='Jameson'+i;
            testContact.CurrencyIsoCode = 'GBP';
            testContact.Status__c = 'Active';
            testContact.Role__c = 'Handler';
            testContact.AccountId = acc.Id;
            conList.add(testContact);
        }
        insert conList;
    }
    
    public static void testFirmTeam () {
        Firm_Team__c testFirmTeam = new Firm_Team__c(Name = 'Legalsmiths Team A' );
        insert testFirmTeam;
    }   
    
    public static void testFirmTeamBulk() {
        List<Firm_Team__c> ftList = new List<Firm_Team__c>();
        List<Contact> conList1 = new List<Contact>();
        List<Contact> conList2 = new List<Contact>();
        List<Contact> conList3 = new List<Contact>();
        List<Account> accList = new List<Account>();
        for (Integer i=0;i<10;i++)
        {
            Account testAccount = new Account();
            testAccount.Name='LegalS'+i;
            testAccount.Sub_Type__c='Legal';
            testAccount.Firm_Supervisor_Email__c= 'supervisor'+i+'@inap.com';
            accList.add(testAccount);
        }
        insert accList;
        for (Account acc:accList)
            for (Integer i=0;i<5;i++)
        {
            Contact testContact = new Contact();
            testContact.FirstName ='James'+i;
            testContact.LastName='Jameson'+i;
            testContact.CurrencyIsoCode = 'GBP';
            testContact.Status__c = 'Active';
            testContact.Role__c = 'Handler';
            testContact.AccountId = acc.Id;
            conList1.add(testContact);
        }
        insert conList1;
        for (Account acc:accList)
            for (Integer i=0;i<5;i++)
        {
            Contact testContact = new Contact();
            testContact.FirstName ='John'+i;
            testContact.LastName='Johnson'+i;
            testContact.CurrencyIsoCode = 'GBP';
            testContact.Status__c = 'Active';
            testContact.Role__c = 'Handler';
            testContact.AccountId = acc.Id;
            conList2.add(testContact);
        }
        insert conList2;
        for (Account acc:accList)
            for (Integer i=0;i<5;i++)
        {
            Contact testContact = new Contact();
            testContact.FirstName ='Susan'+i;
            testContact.LastName='Sarandon'+i;
            testContact.CurrencyIsoCode = 'GBP';
            testContact.Status__c = 'Active';
            testContact.Role__c = 'Handler';
            testContact.AccountId = acc.Id;
            conList3.add(testContact);
        }
        insert conList3;
        for (Account acc:accList)
            for (Integer i=0;i<3;i++)
        {
            Firm_Team__c testFirmTeam = new Firm_Team__c();
            testFirmTeam.Name =acc.Name+i;
            testFirmTeam.Firm__c = acc.Id;
            testFirmTeam.Status__c = 'Inactive';
            ftList.add(testFirmTeam);
        }
        insert ftList;
    }
    
    
    
    public static void testFirmTeamRole () {
        Firm_Team_Roles__c testFirmTeamRole = new Firm_Team_Roles__c(Roles__c = 'Case Handler', Firm_Team__c = '', Contact__c = '');
        insert testFirmTeamRole;
    }
    
    public static void testFirmTeamRoleBulk() {
        List<Firm_Team_Roles__c> ftrList = new List<Firm_Team_Roles__c>();
        List<Firm_Team__c> ftList = new List<Firm_Team__c>();
        List<Contact> conList1 = new List<Contact>();
        List<Contact> conList2 = new List<Contact>();
        List<Contact> conList3 = new List<Contact>();
        List<Account> accList = new List<Account>();
        for (Integer i=0;i<10;i++)
        {
            Account testAccount = new Account();
            testAccount.Name='LegalS'+i;
            testAccount.Sub_Type__c='Legal';
            testAccount.Firm_Supervisor_Email__c= 'supervisor'+i+'@inap.com';
            accList.add(testAccount);
        }
        insert accList;
        for (Account acc:accList)
            for (Integer i=0;i<5;i++)
        {
            Contact testContact = new Contact();
            testContact.FirstName ='James'+i;
            testContact.LastName='Jameson'+i;
            testContact.CurrencyIsoCode = 'GBP';
            testContact.Status__c = 'Active';
            testContact.Role__c = 'Handler';
            testContact.AccountId = acc.Id;
            conList1.add(testContact);
        }
        insert conList1;
        for (Account acc:accList)
            for (Integer i=0;i<5;i++)
        {
            Contact testContact = new Contact();
            testContact.FirstName ='John'+i;
            testContact.LastName='Johnson'+i;
            testContact.CurrencyIsoCode = 'GBP';
            testContact.Status__c = 'Active';
            testContact.Role__c = 'Handler';
            testContact.AccountId = acc.Id;
            conList2.add(testContact);
        }
        insert conList2;
        for (Account acc:accList)
            for (Integer i=0;i<5;i++)
        {
            Contact testContact = new Contact();
            testContact.FirstName ='Susan'+i;
            testContact.LastName='Sarandon'+i;
            testContact.CurrencyIsoCode = 'GBP';
            testContact.Status__c = 'Active';
            testContact.Role__c = 'Handler';
            testContact.AccountId = acc.Id;
            conList3.add(testContact);
        }
        insert conList3;
        for (Account acc:accList)
            for (Integer i=0;i<3;i++)
        {
            Firm_Team__c testFirmTeam = new Firm_Team__c();
            testFirmTeam.Name =acc.Name+i;
            testFirmTeam.Firm__c = acc.Id;
            testFirmTeam.Status__c = 'Inactive';
            ftList.add(testFirmTeam);
        }
        insert ftList;
        for (Contact con:conList1)
            for (Integer i=0;i<5;i++)
        {
            Firm_Team_Roles__c testFirmTeamRole = new Firm_Team_Roles__c();
            // testFirmTeamRole.Firm_Team__c = ft.Id;
            testFirmTeamRole.Contact__c = con.Id;
            testFirmTeamRole.Roles__c = 'Case Handler';
            
        }
    }
    
    
    
    public static void testIncident () {
        Datetime myDate = Datetime.newInstance(2019, 4, 15, 12, 30, 2);
        Incident_Information__c testIncident = new Incident_Information__c(Incident_Date__c = myDate, Address_Line_1__c = '21B Baker Street', Country__c = 'United Kingdom', Description__c = 'High speed motor vehicle accident');
        insert testIncident;
    }
    
    public static void testIncidentBulk() {
        Datetime myDate = Datetime.newInstance(2019, 4, 15, 12, 30, 2);
        List<Incident_Information__c> incList = new List<Incident_information__c>();
        for (Integer i=0;i<10;i++)
        {
            Incident_Information__c testIncident = new Incident_Information__c();
            testIncident.Incident_Date__c= myDate;
            testIncident.Address_Line_1__c = '21B Baker Street';
            testIncident.City__c = 'London';
            testIncident.Country__c = 'United Kingdom';
            testIncident.Postal_Code__c = 'NW11 7HB';
            testIncident.Description__c = 'High speed motor vehicle accident';
            incList.add(testIncident);
        }
        insert incList;
    }
    
    public static void testCase () {
        Case testCase = new Case(Case_Source__c = 'Claimant', Status = 'Created');
        insert testCase;
    }
    
    public static void testCaseBulk() {
        List<Case> caseList = new List<Case>();
        for (Integer i=0;i<10;i++)
        {
            Case testCase = new Case();
            testCase.Case_Source__c= 'Claimant';
            testCase.Status = 'Created';
            caseList.add(testCase);
        }
        insert caseList;
    }
    
    public static void testClaimantPerson () {
        Date myDate = Date.newInstance(1982, 6, 1);
        Claimant_Information__c testClaimantPerson = new Claimant_Information__c(Claimant_First_Name__c = 'Nicholas', Claimant_Last_Name__c = 'Cage', Claimant_Date_of_Birth__c = myDate);
        insert testClaimantPerson;
    }
    
    public static void testClaimantPersonBulk() {
        Date myDate = Date.newInstance(1982, 6, 1);
        List<Claimant_Information__c> claimantPersonList = new List<Claimant_Information__c>();
        for (Integer i=0;i<10;i++)
        {
            Claimant_Information__c testClaimantPerson = new Claimant_Information__c();
            testClaimantPerson.Claimant_First_Name__c= 'Nicholas'+i;
            testClaimantPerson.Claimant_Last_Name__c = 'Cage'+i;
            testClaimantPerson.Claimant_Date_of_Birth__c = myDate;
            claimantPersonList.add(testClaimantPerson);
        }
        insert claimantPersonList;
    }
    
    public static void testDefendantPerson () {
        Date myDate = Date.newInstance(1986, 8, 21);
        Defendant_Information__c testDefendantPerson = new Defendant_Information__c(Defendant_First_Name__c = 'John', Defendant_Last_Name__c = 'Wick', Defendant_Date_of_Birth__c = myDate);
        insert testDefendantPerson;
    }
    
    public static void testDefendantPersonBulk() {
        Date myDate = Date.newInstance(1986, 8, 21);
        List<Defendant_Information__c> defendantPersonList = new List<Defendant_Information__c>();
        for (Integer i=0;i<10;i++)
        {
            Defendant_Information__c testDefendantPerson = new Defendant_Information__c();
            testDefendantPerson.Defendant_First_Name__c= 'John'+i;
            testDefendantPerson.Defendant_Last_Name__c = 'Wick'+i;
            testDefendantPerson.Defendant_Date_of_Birth__c = myDate;
            defendantPersonList.add(testDefendantPerson);
        }
        insert defendantPersonList;
    }
    
    public static void testDefendantCompany () {
        Defendant_Information__c testDefendantCompany = new Defendant_Information__c(Company_Employer_Name__c = 'McDonalds', Contact_First_Name__c = 'Dave', Contact_Last_Name__c = 'Davis', Address_Line_1__c = '5 Shepstone Way', City__c = 'Surrey', Country__c = 'United Kingdom', Postal_Code__c = 'NW11 5XB');
        insert testDefendantCompany;
    } 
    
    public static void testDefendantCompanyBulk() {
        Date myDate = Date.newInstance(1986, 8, 21);
        List<Defendant_Information__c> defendantCompanyList = new List<Defendant_Information__c>();
        for (Integer i=0;i<10;i++)
        {
            Defendant_Information__c testDefendantCompany = new Defendant_Information__c();
            testDefendantCompany.Company_Employer_Name__c= 'McDonalds'+i;
            testDefendantCompany.Contact_First_Name__c = 'Dave'+i;
            testDefendantCompany.Contact_Last_Name__c = 'Davis'+i;
            testDefendantCompany.Address_Line_1__c = '5 Shepstone Way';
            testDefendantCompany.City__c = 'London';
            testDefendantCompany.Country__c = 'United Kingdom';
            testDefendantCompany.Postal_Code__c = 'NW11 7HB';
            defendantCompanyList.add(testDefendantCompany);
        }
        insert defendantCompanyList;
    }
    
    public static void testSOL () {
        Schedule_of_Losses__c testSOL = new Schedule_of_Losses__c(Case__c = '', Claimant_Information__c = '');
        insert testSOL;
    } 
    
    public static void testDefendantFirm () {
        Defendant_Firm__c testDefendantFirm = new Defendant_Firm__c(Case__c = '');
        insert testDefendantFirm;
    }
    
    public static void testMerit () {
        Merit__c testMerit = new Merit__c(Name = 'DefendantLiability', Related_Case__c = '', Schedule_of_Losses__c = '');
        insert testMerit;
    }
    
    public static void testPFL () {
        Loss_Category__c testPFL = new Loss_Category__c(Head_of_Loss_Type__c = 'Past Financial Losses', Case__c = '', Schedule_of_Losses__c = '');
        insert testPFL;
    }
    
    public static void testPSLA () {
        Loss_Category__c testPSLA = new Loss_Category__c(Head_of_Loss_Type__c = 'Personal Injury and Loss of Amenity', Case__c = '', Schedule_of_Losses__c = '');
        insert testPSLA;
    }
    
    public static void testFFL () {
        Loss_Category__c testFFL = new Loss_Category__c(Head_of_Loss_Type__c = 'Future Financial Losses', Case__c = '', Schedule_of_Losses__c = '');
        insert testFFL;
    }
    
    public static void testLossOfCongenialEmployment () {
        Loss_Category__c testLossOfCongenialEmployment = new Loss_Category__c(Head_of_Loss_Type__c = 'Loss of Congenial Employment', Case__c = '', Schedule_of_Losses__c = '');
        insert testLossOfCongenialEmployment;
    }
    
    public static void testDisadvantageOnTheOpenLabourMarket () {
        Loss_Category__c testDisadvantageOnTheOpenLabourMarket = new Loss_Category__c(Head_of_Loss_Type__c = 'Disadvantage on Labour Market', Case__c = '', Schedule_of_Losses__c = '');
        insert testDisadvantageOnTheOpenLabourMarket;
    }
    
    public static void testBereavement () {
        Loss_Category__c testBereavement = new Loss_Category__c(Head_of_Loss_Type__c = 'Bereavement', Case__c = '', Schedule_of_Losses__c = '');
        insert testBereavement;
    }
    
    public static void testLegalCosts () {
        Loss_Category__c testLegalCosts = new Loss_Category__c(Head_of_Loss_Type__c = 'Legal Costs', Case__c = '', Schedule_of_Losses__c = '');
        insert testLegalCosts;
    }
    
}