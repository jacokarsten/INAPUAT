Public Class FromFirm_Remove{


//@invocablemethod
Public static Boolean RemoveAll(List<Id> AccId){
    Boolean Active=FirmMemberTeamHandler.CheckForActiveFirm(AccId);
    
    if(Active){
      
      /*
        Account[] firm = [Select id,Deactivate_Validation__c  from Account where id in:AccId];
        for(Account acc:firm){
            acc.Deactivate_Validation__c =true;
        } 
        update firm;
      */  
    }
    else{ 
    
        FirmMemberTeamHandler.RemoveAllFromfirm(AccId);
    }
    
   return Active;  
}


}