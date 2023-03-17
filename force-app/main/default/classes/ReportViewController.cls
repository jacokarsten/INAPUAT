public class ReportViewController {

    @AuraEnabled
    public static List<Report> getInapReports() {
        List<Report> inapReports = [SELECT Description,
                                    DeveloperName,
                                    FolderName,
                                    Id,
                                    Name 
                                    FROM Report 
                                    WHERE FolderName = 'Case Handler Reports'];
        
        return inapReports;
    
    }
}