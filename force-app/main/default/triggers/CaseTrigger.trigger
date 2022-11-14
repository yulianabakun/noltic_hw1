trigger CaseTrigger on Case (before insert, before update, before delete, after insert, after update, after delete) {
    CaseHandler.handle(Trigger.new, Trigger.oldMap, Trigger.operationType);
}