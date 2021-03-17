trigger CandidateTrigger on Candidate__c (before insert, before update, after undelete) {
    if (Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            CandidateTriggerHandler.onBeforeInsert(Trigger.new);
        }
        else if (Trigger.isUpdate) 
        {
            CandidateTriggerHandler.onBeforeUpdate(Trigger.new);
        }
    }
    else if (Trigger.isAfter)
    {
        CandidateTriggerHandler.onAfterUndelete(Trigger.new);
    }
}