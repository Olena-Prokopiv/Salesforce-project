public with sharing class JobApplicationVisaHandler {
    public static void onBeforeInsert(List<JobApplication__c> insertedNew) {
        JobApplicationVisaHelper.checkVisaDate(insertedNew);
    }
}
