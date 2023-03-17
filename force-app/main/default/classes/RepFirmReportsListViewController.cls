public class RepFirmReportsListViewController {
    
    @AuraEnabled
    public static List<Report> getInapReports() {
        List<Report> inapReports = [SELECT Description,
                                    DeveloperName,
                                    FolderName,
                                    Id,
                                    Name 
                                    FROM Report 
                                    WHERE FolderName = 'Representative Firm Reports'];
        
        return inapReports;
    
    }

}