global class Batch_SOLHandler implements Database.Batchable<sObject>,Schedulable, Database.AllowsCallouts, Database.Stateful{
       
    global Database.QueryLocator start(Database.BatchableContext BC){  
                   
        return Database.getQueryLocator([Select id from Case where Stage__c ='Negotiation']);    
    }

    global void execute(Database.BatchableContext BC, List<Case> scope){
       
       Set<String> set_Case = new Set<String>();
                 
       for(Case var : scope){
           set_Case.add(var.id);           
       }
      
       SOLHandler.ResetArbitration(set_Case);
       
      
    }

    global void finish(Database.BatchableContext BC){
        
    }
    
    
    global void execute(SchedulableContext sc)
    {
        Batch_SOLHandler SOLHandler = new Batch_SOLHandler();
        database.executebatch(SOLHandler ,1);
    }
    
}