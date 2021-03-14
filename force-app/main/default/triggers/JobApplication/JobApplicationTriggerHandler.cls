public with sharing class JobApplicationTriggerHandler {
    public static void onBeforeInsert(List<JobApplication__c> insertedNew) {
        JobApplicationTriggerHelper.checkVisaDate(insertedNew);
    }
}
