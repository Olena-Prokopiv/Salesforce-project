trigger JobApplicationVisa on JobApplication__c (before insert) {
    JobApplicationVisaHandler.onBeforeInsert(Trigger.new);
}