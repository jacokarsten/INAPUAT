public class MarketMakerReportsListViewController {
    
    @AuraEnabled
    public static List<Report> getInapReports() {
        List<Report> inapReports = [SELECT Description,
                                    DeveloperName,
                                    FolderName,
                                    Id,
                                    Name 
                                    FROM Report 
                                    WHERE FolderName = 'Market Maker Reports'];
        
        return inapReports;
    
    }

}