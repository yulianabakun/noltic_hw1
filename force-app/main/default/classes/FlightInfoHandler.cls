public with sharing class FlightInfoHandler {
    public static void handle(List<Flight_Info__c> records, Map<Id, Flight_Info__c> oldRecords, TriggerOperation operation){
        switch on operation {
            when AFTER_INSERT {
                FlightInfoService.preventDoubleFlights(records);
            }
            when AFTER_UPDATE{
                FlightInfoService.preventDoubleFlights(records, oldRecords);
            }
        }
    }
}