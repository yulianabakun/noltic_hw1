public with sharing class CountrySelector {

    public static List<Country__c> getByIds(Set<Id> ids) {
        return [
                SELECT Id, SuccessMessage__c, ClosedCases__c, (
                        SELECT Id
                        FROM Cases__r
                        WHERE Status = 'Closed'
                )
                FROM Country__c
                WHERE Id IN :ids
        ];
    }
}
