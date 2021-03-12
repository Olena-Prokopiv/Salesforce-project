trigger CandidateVisaHolder on Candidate__c (before insert,before update) {
    if(Trigger.isInsert)
    {
        CandidateVisaHolderHandler.onBeforeInsert(Trigger.new);
    }
    if(Trigger.isUpdate)
    {
        CandidateVisaHolderHandler.onBeforeUpdate(Trigger.old);
    }
}