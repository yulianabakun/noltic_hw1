public with sharing class MorningCaseCreatorScheduler implements Schedulable {

    public static void schedule() {
        MorningCaseCreatorScheduler caseCreator = new MorningCaseCreatorScheduler();
        String sch = '0 0 7 ? * * *';
        String jobID = System.schedule('Create Case in the morning', sch, caseCreator);
    }

    public void execute(SchedulableContext ctx) {

        Datetime d = Date.today() ;
        String dateStr =  d.format('dd/mm/yyyy') ;

        Case c = new Case (Subject = 'Morning Case - ' + dateStr);
        insert c;


    }


}