/**
 * Created by Yulisha on 7/22/2022.
 */

public with sharing class Homework10 {
    public static List<Opportunity> updateOpportunityStage (String stageNew, String stageOld){
        List<Schema.PicklistEntry> opportunityStages = Opportunity.StageName.getDescribe().getPicklistValues();
        Set<String> picklistValues = new Set<String>();
        for (PicklistEntry picklistEntry : opportunityStages) {
            picklistValues.add(picklistEntry.value);
        }
        if(!picklistValues.contains(stageNew) || !picklistValues.contains(stageOld)){
            throw new Homework10Exception('incorrect picklist value');
        }
        List<Opportunity> opps = [
                SELECT Id, StageName
                FROM Opportunity
                WHERE StageName = :stageOld
        ];

        for( Opportunity opp : opps){
            opp.StageName = stageNew;
        }
        update opps;
        return opps;

    }
    public class Homework10Exception extends Exception {

    }
}