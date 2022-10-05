trigger FlightInfoTrigger on Flight_Info__c (before insert, before update, before delete, after insert, after update, after delete) {
    FlightInfoHandler.handle(Trigger.new, Trigger.oldMap, Trigger.operationType);
}