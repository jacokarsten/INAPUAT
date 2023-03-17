trigger accountrigger on Account (before update, before insert) {

 
    if(trigger.isupdate){
        
            if(trigger.isbefore){
                if(StatusChangeHandler.STATUSCHANGETRIGGER!=True){
                    StatusChangeHandler.FromFirm(trigger.old,trigger.new);
                }                
            }
        
    }
    if(trigger.isinsert){
        
            if(trigger.isbefore){
             AccountHandler.SetUpHandler(trigger.new);                 
            }
        
    }
    
}