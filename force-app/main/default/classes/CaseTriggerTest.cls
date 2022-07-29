/**
 * Created by Yulisha on 7/29/2022.
 */

@IsTest class CaseTriggerTest {

    @IsTest static void testUpdateCaseSuccessMessage() {
        // GIVEN
        Country__c country = new Country__c(Name = 'Ukraine', SuccessMessage__c = 'Test');
        insert country;
        Case aCase = new Case(Country__c = country.Id, Status = 'Pending');
        insert aCase;

        // WHEN
        aCase.Status = 'Closed';
        update aCase;

        // THEN
        System.assertEquals(country.SuccessMessage__c, [SELECT SuccessMessage__c FROM Case].SuccessMessage__c);
    }

    @IsTest static void testClosedCaseCountOnCountry() {
        // GIVEN
        Country__c country = new Country__c(Name = 'Ukraine', ClosedCases__c = 0);
        insert country;
        Case aCase = new Case(Country__c = country.Id, Status = 'Pending');
        insert aCase;

        // WHEN
        aCase.Status = 'Closed';
        update aCase;

        // THEN
        System.assertEquals(1, [SELECT ClosedCases__c FROM Country__c].ClosedCases__c);
    }
}