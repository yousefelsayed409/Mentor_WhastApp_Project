// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationService() {
//     // إعدادات الإشعارات المحلية
//     _initializeLocalNotifications();
//     // إعداد FCM
//     _setupFirebaseMessaging();
//   }

//   Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void _setupFirebaseMessaging() {
//     // طلب إذن الإشعارات
//     _requestPermission();

//     // إعدادات استقبال الرسائل في حالة التطبيق مفتوح
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Received a message while in the foreground!');
//       _showLocalNotification(message);
//     });

//     // إعدادات استقبال الرسائل عند الضغط على الإشعار
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('Message clicked!');
//       // تنفيذ إجراء عند فتح الإشعار
//     });

//     // إعدادات استقبال الرسائل في الخلفية
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }

//   Future<void> _requestPermission() async {
//     NotificationSettings settings = await _firebaseMessaging.requestPermission();
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }

//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     print('Handling a background message: ${message.messageId}');
//     // تنفيذ إجراء مناسب عند تلقي رسالة في الخلفية
//   }

//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id', // معرف القناة
//       'your_channel_name', // اسم القناة
//       // 'your_channel_description', // وصف القناة
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await _flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//       payload: message.data['data'], // يمكنك استخدام هذا لتحويل البيانات
//     );
//   }
// }
