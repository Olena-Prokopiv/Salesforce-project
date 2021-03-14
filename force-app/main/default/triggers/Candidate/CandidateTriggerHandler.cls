public with sharing class CandidateTriggerHandler {
    public static void onBeforeInsert(List<Candidate__c> insertedNew)
    {
        CandidateTriggerHelper.showError(insertedNew);
    }

    public static void onBeforeUpdate( List<Candidate__c> updatedNew) 
    {
        CandidateTriggerHelper.showError(updatedNew);
    }

    public static void onAfterUndelete(List<Candidate__c> undeletedNew) {
        CandidateTriggerHelper.changeRecovered(undeletedNew);
    }
}
