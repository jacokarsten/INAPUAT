Public Class FromFirm_Deactivate{


//@invocablemethod
Public static Boolean DactivateAll(List<Id> AccId){
   /*
    Boolean Active=FirmMemberTeamHandler.CheckForActiveFirm(AccId);
    
    if(Active){
      
        
    }
    else{ 
        System.Debug('**Two**');
        
    } 
    */
    
    
    FirmMemberTeamHandler.DeactiveAllFromfirm(AccId);
    
    return false;   
}


}