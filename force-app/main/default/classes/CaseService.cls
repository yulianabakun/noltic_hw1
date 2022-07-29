public with sharing class CaseService {
    public static void updateCaseSuccessMessage(List<Case> cases, Map<Id, Case> oldCases) {
        Map<Id, Country__c> countries = new Map<Id, Country__c>(getClosedCaseCountries(cases, oldCases));

        for (Case c : cases) {
            if (c.Country__c == null) {
                continue;
            }

            c.SuccessMessage__c = countries.get(c.Country__c).SuccessMessage__c;
        }
    }

    public static void updateClosedCasesCount(List<Case> cases, Map<Id, Case> oldCases) {
        List<Country__c> countries = getClosedCaseCountries(cases, oldCases);

        for (Country__c country: countries) {
            country.ClosedCases__c = country.Cases__r.size();
        }

        update countries;
    }

    private static List<Country__c> getClosedCaseCountries(List<Case> cases, Map<Id, Case> oldCases) {
        Set<Id> countryIds = new Set<Id>();

        for (Case c : cases) {
            if (c.Status == 'Closed' && oldCases.get(c.Id).Status != 'Closed') {
                countryIds.add(c.Country__c);
            }

        }

        return CountrySelector.getByIds(countryIds);
    }
}
