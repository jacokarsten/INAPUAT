@istest

Public class ClaimantRelatedList_test{


Public static testmethod void ClaimantRelatedListtest(){

    test.starttest();
    
        Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
        Test_SetUpCaseProtocol_1.testCreateProtocol();
        Case[] cs = [Select id from  Case];
        
        ClaimantRelatedList.getClaimantInfo(cs[0].id);
        
    test.stoptest();
    

}



}