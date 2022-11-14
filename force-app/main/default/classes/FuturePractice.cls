public with sharing class FuturePractice {
    @future
    public static void createAccountFuture(String accountName) {
        Account acc = new Account(Name = accountName);
        insert acc;
    }
}