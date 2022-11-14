/**
 * Created by Yulisha on 8/24/2022.
 */

public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Diary__c> getRelatedDiaries(Id contactId){
        return [
                SELECT Id, CreatedDate, Note__c
                FROM Diary__c
                WHERE Contact__c = :contactId
                WITH SECURITY_ENFORCED
        ];
    }

}