public with sharing class CreateAccountQueueable implements Queueable {
        private String name;
        public CreateAccountQueueable(String name){
            this.name = name;
        }
        public void execute(QueueableContext context){
            Account acc = new Account();
            acc.Name = this.name;
            insert acc;
        }

}