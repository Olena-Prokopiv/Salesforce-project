public with sharing class JobPositionSFHandler {
    public static void onBeforeInsert(List<JobPosition__c> insertedNew) {
        JobPositionSFHelper.updateJobPositionsTitle(insertedNew);
    }
}
