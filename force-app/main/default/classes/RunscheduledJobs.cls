Public Class RunscheduledJobs{




Public void RunReferals(){
        
        Batch_CaseReferalHandler updateReferal = new Batch_CaseReferalHandler();
        database.executebatch(updateReferal ,10);
}

Public void runResetArb(){
        Batch_SOLHandler SOLHandler = new Batch_SOLHandler();
        database.executebatch(SOLHandler ,10);

}

Public void RunNotifications(){

        Batch_CaseNotification updatenotifications = new Batch_CaseNotification();
        database.executebatch(updatenotifications ,10);

}




}