trigger JobApplicationTrigger on JobApplication__c (before insert) {
    JobApplicationTriggerHandler.onBeforeInsert(Trigger.new);
}