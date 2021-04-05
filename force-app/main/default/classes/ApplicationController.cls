public with sharing class ApplicationController {
    @AuraEnabled(cacheable=true)
    public static List<JobApplication__c> getApplicationList() {
        return [
            SELECT Name, JobPosition__c, Expected_Salary__c, HR_phone_number__c
            FROM JobApplication__c 
            WHERE JobPosition__r.Open_Due_Date__c>TODAY 
            // WITH SECURITY_ENFORCED
            ORDER BY JobPosition__c,Expected_Salary__c
        ];
    }

    @AuraEnabled(cacheable=false)
    public static void deleteApplications(List<Id> lstApplicationIds){
        List<JobApplication__c> lstToDelete = new List<JobApplication__c>();

        try {
            for(Id idApplication : lstApplicationIds) {
                lstToDelete.add(new JobApplication__c(Id = idApplication));
            }
            if(!lstToDelete.isEmpty()) {
                delete lstToDelete;
            }
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}