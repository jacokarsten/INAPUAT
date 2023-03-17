trigger Contacttrigger on Contact (before update) {


    if(trigger.isupdate){
        
            if(trigger.isbefore){
                
                if(StatusChangeHandler.STATUSCHANGETRIGGER!=True){
                    StatusChangeHandler.FromContact(trigger.old,trigger.new);
                }  
                    
             } 
                
                               
     
        
    }


    
}