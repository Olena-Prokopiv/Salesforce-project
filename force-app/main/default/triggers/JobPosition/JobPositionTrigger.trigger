trigger JobPositionTrigger on JobPosition__c (before insert,before update) {
    if(Trigger.isInsert)
    {
        JobPositionTriggerHandler.onBeforeInsert(Trigger.new);
    }
    else
    {
        JobPositionTriggerHandler.onBeforeUpdate(Trigger.oldMap,Trigger.newMap);
    }
}