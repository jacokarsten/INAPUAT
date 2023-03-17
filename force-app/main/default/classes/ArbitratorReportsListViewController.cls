public class ArbitratorReportsListViewController {

    @AuraEnabled
    public static List<Report> getInapReports() {
        List<Report> inapReports = [SELECT Description,
                                    DeveloperName,
                                    FolderName,
                                    Id,
                                    Name 
                                    FROM Report 
                                    WHERE FolderName = 'Arbitrator Reports'];
        
        return inapReports;
    
    }
    
}