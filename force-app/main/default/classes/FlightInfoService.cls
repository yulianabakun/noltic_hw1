public with sharing class FlightInfoService {
    public static void preventDoubleFlights(List<Flight_Info__c> records, Map<Id, Flight_Info__c> oldRecords) {
        List<Flight_Info__c> flightInfos = filterFlightsWithChangedTime(records, oldRecords);

        preventDoubleFlights(flightInfos);
    }

    public static void preventDoubleFlights(List<Flight_Info__c> records) {
        Set<Id> planeIds = new Set<Id>();

        for (Flight_Info__c flightInfo : records) {
            planeIds.add(flightInfo.Aircraft__c);
        }

        List<Aircraft__c> aircrafts = [SELECT Id, (
                SELECT Id, Date_time_of_Flight__c, Date_time_of_Arrival__c
                FROM Flight_Info__r
                ORDER BY Date_time_of_Flight__c, Date_time_of_Arrival__c
        ) FROM Aircraft__c];

        for (Aircraft__c aircraft : aircrafts) {
            for (Integer i = 0; i < aircraft.Flight_Info__r.size() - 1; i++) {
                Flight_Info__c current = aircraft.Flight_Info__r[i];
                Flight_Info__c next = aircraft.Flight_Info__r[i + 1];

                if (next.Date_time_of_Flight__c < current.Date_time_of_Arrival__c) {
                    throw new DoubleFlightException('Can\'t have double flight at the same time');
                }
            }
        }
    }

    private static List<Flight_Info__c> filterFlightsWithChangedTime(List<Flight_Info__c> records, Map<Id, Flight_Info__c> oldRecords) {
        List<Flight_Info__c> result = new List<Flight_Info__c>();

        for (Flight_Info__c flightInfo : records) {
            Flight_Info__c oldRecord = oldRecords.get(flightInfo.Id);

            if (flightInfo.Date_time_of_Flight__c != oldRecords.get(flightInfo.Id).Date_time_of_Flight__c ||
                    flightInfo.Duration__c != oldRecord.Duration__c
            ) {
                result.add(flightInfo);
            }
        }

        return result;
    }

    public class DoubleFlightException extends Exception {}
}