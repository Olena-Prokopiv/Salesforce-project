trigger JobPositionTrigger on JobPosition__c (before insert,before update) {
    if(Trigger.isInsert)
    {
        JobPositionTriggerHandler.onBeforeInsert(Trigger.new);
    }
    else if(Trigger.isUpdate)
    {
        JobPositionTriggerHandler.onBeforeUpdate(Trigger.oldMap,Trigger.newMap);
    }
}