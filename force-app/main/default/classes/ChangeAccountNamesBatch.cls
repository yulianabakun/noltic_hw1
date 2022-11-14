public with sharing class ChangeAccountNamesBatch implements Database.Batchable<sObject>  {
    public List<SObject> start(Database.BatchableContext bc){
        return [SELECT Id, Name FROM Account];
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        for(Account account: scope){
            account.Name += 'Batch Processed';
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){
        Id job= bc.getJobId();
        System.debug(job);
    }
}