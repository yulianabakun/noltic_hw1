public with sharing class TicketHandler {
    public static void handle(List<Ticket__c> newTickets, Map<Id,Ticket__c> oldTickets, TriggerOperation operation){
        switch on operation {
            when AFTER_INSERT {
                TicketService.updateBookedSeatsCount(newTickets);
            }
            when AFTER_UPDATE{
                TicketService.updateBookedSeatsCount(newTickets, oldTickets);
                TicketService.updateMiles(newTickets, oldTickets);
            }
        }
    }
}