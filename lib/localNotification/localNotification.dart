import 'package:awesome_notifications/awesome_notifications.dart';

/*******Notification function code*******/
triggerNotification() {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 410,
        channelKey: "basic_channel",
        title: "SOFTBENZ",
        body: "Thank you for Contacting Us!!!"),
  );
}
