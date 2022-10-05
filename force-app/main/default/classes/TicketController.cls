public with sharing class TicketController {
    @AuraEnabled
    public static void createTicket(Id recordId, String destination, String departure, String type, Datetime flightDate) {
        List<Flight_Info__c> flightInfo = [
                SELECT Id
                FROM Flight_Info__c
                WHERE Departure__c = :departure AND
                Destination__c = :destination AND
                Date_time_of_Flight__c >= :flightDate AND
                Date_time_of_Arrival__c <= :flightDate
        ];

        if (flightInfo.isEmpty()) {
            throw new AuraHandledException('Not Flight Info Found');
        }

        try {
            Id recordTypeId = SObjectType.Ticket__c.getRecordTypeInfosByDeveloperName().get(type).recordTypeId;
            insert new Ticket__c(Customer__c = recordId, Flight_Info__c = flightInfo[0].Id, RecordTypeId = recordTypeId);
        }
        catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}