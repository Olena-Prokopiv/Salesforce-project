public with sharing class CandidateVisaHolderHandler {
    public static void onBeforeInsert(List<Candidate__c> insertedNew)
    {
        CandidateVisaHolderHelper.showError(insertedNew);
    }

    public static void onBeforeUpdate( List<Candidate__c> updatedOld) 
    {
        CandidateVisaHolderHelper.showError(updatedOld);
    }
}