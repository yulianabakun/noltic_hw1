public with sharing class TicketService {

    public static void updateMiles(List<Ticket__c> tickets, Map<Id, Ticket__c> oldTicket) {
        List<Ticket__c> ticketsWithChangedStatus = filterStatusChanged(tickets, oldTicket);

        Set<Id> ids = new Set<Id>();
        for(Ticket__c t : ticketsWithChangedStatus){
            ids.add(t.Customer__c);
        }

        List<Contact> contacts = [
                SELECT Id, Miles__c,
                (
                        SELECT Id, Flight_Info__r.Distance__c
                        FROM Tickets__r
                        WHERE Status__c = 'Completed'
                )
                FROM Contact
                WHERE Id IN :ids
        ];

        for (Contact c : contacts) {
            c.Miles__c = 0;

            for (Ticket__c ticket : c.Tickets__r) {
                if(ticket.RecordType.DeveloperName == 'Economy'){
                    c.Miles__c += 0.1 * ticket.Flight_Info__r.Distance__c;
                } else if(ticket.RecordType.DeveloperName == 'Business') {
                    c.Miles__c += 0.3 * ticket.Flight_Info__r.Distance__c;
                }
            }
        }

        update contacts;
    }
    public static void updateBookedSeatsCount(List<Ticket__c> tickets, Map<Id, Ticket__c> oldTickets){
        List<Ticket__c> ticketsWithChangedStatus = filterStatusChanged(tickets, oldTickets);

        updateBookedSeatsCount(ticketsWithChangedStatus);
    }

    public static void updateBookedSeatsCount(List<Ticket__c> tickets){
        Set<Id> ids = new Set<Id>();
        for(Ticket__c t : tickets){
            ids.add(t.Flight_Info__c);
        }
        List<Flight_Info__c> flightInfos = [
                SELECT Id,
                (
                        SELECT Id, Status__c, RecordType.DeveloperName
                        FROM Tickets__r
                        WHERE Status__c = 'Booked' OR Status__c = 'Completed'
                )
                FROM Flight_Info__c
                WHERE Id IN :ids
        ];

        for (Flight_Info__c flightInfo : flightInfos) {
            flightInfo.Booked_Economy_Seats__c = 0;
            flightInfo.Booked_Business_Seats__c = 0;

            for (Ticket__c ticket : flightInfo.Tickets__r) {
                if(ticket.RecordType.DeveloperName == 'Economy'){
                    flightInfo.Booked_Economy_Seats__c += 1;
                } else if(ticket.RecordType.DeveloperName == 'Business') {
                    flightInfo.Booked_Business_Seats__c += 1;
                }
            }
        }
        update flightInfos;

    }

    public static List<Ticket__c> filterStatusChanged(List<Ticket__c> tickets, Map<Id, Ticket__c> oldTickets) {
        List<Ticket__c> result = new List<Ticket__c>();

        for (Ticket__c ticket : tickets) {
            if (ticket.Status__c != oldTickets.get(ticket.Id).Status__c) {
                result.add(ticket);
            }
        }

        return result;
    }
}