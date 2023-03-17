@istest

Public class DefendantRelatedList_test{


Public static testmethod void DefendantRelatedListtest(){

    test.starttest();
    
        Test_InsertFirm_Contact_Team_TeamRole.insertContactUser2();
        Test_SetUpCaseProtocol_1.testCreateProtocol();
         Case[] cs = [Select id from  Case];
        
        DefendantRelatedList.getDefendantInfo(cs[0].id);
        
    test.stoptest();
    

}



}