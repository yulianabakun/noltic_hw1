/**
 * Created by Yulisha on 9/4/2022.
 */

public with sharing class EmailNotificationSender implements NotificationSender {

    public void sendNotification(String notificationMessage) {
        List<Messaging.SingleEmailMessage> mails =
                new List<Messaging.SingleEmailMessage>();

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        List<String> sendTo = new List<String>();
        sendTo.add(UserInfo.getUserEmail());
        mail.setToAddresses(sendTo);

        mail.setSubject('URGENT PROPOSAL');

        mail.setHtmlBody(notificationMessage);

        mails.add(mail);
        Messaging.sendEmail(mails);
    }
}