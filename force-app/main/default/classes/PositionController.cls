public with sharing class PositionController {
    @AuraEnabled(cacheable=true)
    public static List<JobPosition__c> getPositionList() {
        return [
            SELECT Name, Open_Due_Date__c, Practice_Unit__c, Priority__c 
            FROM JobPosition__c 
            WHERE Open_Due_Date__c>TODAY 
           // WITH SECURITY_ENFORCED
            ORDER BY Priority__c 
        ];
    }
}