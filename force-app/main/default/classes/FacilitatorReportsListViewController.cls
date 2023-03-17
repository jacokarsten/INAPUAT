public class FacilitatorReportsListViewController {
    
    @AuraEnabled
    public static List<Report> getInapReports() {
        List<Report> inapReports = [SELECT Description,
                                    DeveloperName,
                                    FolderName,
                                    Id,
                                    Name 
                                    FROM Report 
                                    WHERE FolderName = 'Facilitator Reports'];
        
        return inapReports;
    
    }

}