public inherited sharing class SendCustomNotification {

    public static void sendNotifications(String strBody, String strNotificationId, String strSenderId, String strTargetId, String strTitle, Set<String> setUserIds){
        
        Messaging.CustomNotification obj = new Messaging.CustomNotification();
        
        obj.setNotificationTypeId(strNotificationId);
        
        obj.setTargetId(strTargetId);
        
        obj.setTitle(strTitle);
        
        obj.setBody(strBody);
        
        obj.send(setUserIds);
        
    }
    
    public static CustomNotificationType getCustomNotificationType(String developerName){
        return [Select Id, DeveloperName FROM CustomNotificationType Where DeveloperName = :developerName LIMIT 1];
    }
    
}