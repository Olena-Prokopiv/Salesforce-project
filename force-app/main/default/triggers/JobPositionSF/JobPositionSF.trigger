trigger JobPositionSF on JobPosition__c (before insert) {
    JobPositionSFHandler.onBeforeInsert(Trigger.new);
}