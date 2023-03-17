trigger ProtocolOpetion on Protocol_Option__c (Before Insert, Before Update) {
    
    if(trigger.isbefore){
        ProtocolSetup.PopulateProtocolOptions(trigger.new);
    }
}