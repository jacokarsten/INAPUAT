trigger UserTrigger on User (before update) {
 
    if(trigger.isupdate){
        if(UserHandler.STOPUSERTRIGGER!=True){
            UserHandler.updateContactDetails(trigger.new);
        }
    }

}