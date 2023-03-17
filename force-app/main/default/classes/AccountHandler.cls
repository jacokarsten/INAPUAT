Public Class AccountHandler{


Public static void SetUpHandler(List<Account> lst_Acc){
    
    Set<String> Set_Id = new Set<String>();
    
    Account[] lst_AccFirmID = [Select FirmID__c  From Account where FirmID__c !=: null ];
    
    Integer i=1;
    Decimal FirmIndex=0;
    
    system.debug('**MAX**'+lst_AccFirmID.size());
    
    for(Account acc:lst_AccFirmID ){ 
          if(FirmIndex < integer.valueof(acc.FirmID__c)){
               FirmIndex = integer.valueof(acc.FirmID__c);
          }
    } 
    
    
    
    for(Account acc:lst_Acc){
        acc.FirmID__c = string.valueof(FirmIndex+i);
        i++;
    }
}


}