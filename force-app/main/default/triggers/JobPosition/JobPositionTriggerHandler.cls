public with sharing class JobPositionTriggerHandler {
    public static void onBeforeInsert(List<JobPosition__c> insertedNew) {
        JobPositionTriggerHelper.updateJobPositionsTitle(insertedNew);
    }

    public static void onBeforeUpdate(Map<Id,JobPosition__c> Old,Map<Id,JobPosition__c> updatedNew) {
        JobPositionTriggerHelper.createTaskforHR(Old,updatedNew);
    }
}