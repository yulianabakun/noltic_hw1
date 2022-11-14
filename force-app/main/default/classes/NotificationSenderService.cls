/**
 * Created by Yulisha on 9/4/2022.
 */

public with sharing class NotificationSenderService {
    private NotificationSender sender;
    private String message;

    public void initNotificationSender(NotificationSender sender, String message){
        this.message = message;
        this.sender = sender;
    }

    public void executeSend(){
        this.sender.sendNotification(this.message);
    }


}