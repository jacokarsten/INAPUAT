trigger FirmTeamtrigger on Firm_Team__c (before update, before insert, after update) {
   
            if(trigger.isbefore){
                if(trigger.isinsert){
                         StatusChangeHandler.FromTeam(trigger.new);          
                }
                
                if(trigger.isupdate){
                    
                    if(StatusChangeHandler.STATUSCHANGETRIGGER!=True){
                        StatusChangeHandler.FromTeam(trigger.new);
                     //   StatusChangeHandler.FromTeam(trigger.old,trigger.new); 
                          
                    } 
                                   
                }  
                       
            }
            
            if(trigger.isafter){
                
                
                if(trigger.isupdate){
                    
                    if(StatusChangeHandler.STATUSCHANGETRIGGER!=True){
                       // StatusChangeHandler.FromTeam(trigger.new);
                        StatusChangeHandler.FromTeam(trigger.old,trigger.new); 
                          
                    } 
                                   
                }  
                       
            }
    
}