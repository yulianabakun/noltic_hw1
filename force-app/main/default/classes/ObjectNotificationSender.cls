/**
 * Created by Yulisha on 9/4/2022.
 */

public with sharing class ObjectNotificationSender implements NotificationSender{

    public void sendNotification(String notificationMessage) {
        Notification__c n = new Notification__c();
        n.Notification_Message__c = notificationMessage;
        insert n;
    }
}