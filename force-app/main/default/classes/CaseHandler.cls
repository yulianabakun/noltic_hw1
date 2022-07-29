public class CaseHandler {
    public static void handle(List<Case> newCases, Map<Id, Case> oldCases, TriggerOperation operation) {
        switch on operation {
            when BEFORE_UPDATE {
                CaseService.updateCaseSuccessMessage(newCases, oldCases);
            }
            when AFTER_UPDATE {
                CaseService.updateClosedCasesCount(newCases, oldCases);
            }
        }
    }
}

