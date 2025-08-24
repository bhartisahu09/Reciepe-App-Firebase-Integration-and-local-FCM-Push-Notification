import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recipe_app/screens/see_all_items.dart';
import 'package:recipe_app/services/firebase_options.dart';

class NotificationService {
//----1.Local Notification (4 steps - 1.Notification services(notification_service.dart), 2. Initialize notification(main.dart), 3. Notification function(receipe_provider.dart) 4. Show notification- in see all button click(home_screen.dart))
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//<<<<<<<<<<<<<Local Notification>>>>>>>>>>>>>>>>>>>>>
  static Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

//<<<<<<<<<<<<<Firebase notification>>>>>>>>>>>>>>>>>>>
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    print('Handling a background message: ${message.messageId}');
    await _initizeLocalNotification();
    await _showFlutterNotification(message);
  }

  ///Initilizes Firebase Messaging and local notification
  static Future<void> initilizeFirebaseNotification() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    await _firebaseMessaging.requestPermission();

    //called when message is received while app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Call your function to show the notification
      await _showFlutterNotification(message);
    });

    Future<void> requestNotificationPermission() async {
      final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('Provisional permission granted');
      } else {
        print('Permission denied');
      }
    }

    //called when app is brought t foreground from background by tapping a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from background notification: ${message.data}');
    });

    //Get and print FCM token (for sending target messages)
    await _getFcmToken();

    //Initilized the local notification plugin
    await _initizeLocalNotification();
  }

//FETCHES and print FCM token [optional]
  static Future<void> _getFcmToken() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $fcmToken");
  }

//show local notification when message is received
  static Future<void> _showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    Map<String, dynamic> data = message.data;

    String title = notification?.title ?? data['title'] ?? 'No Title';
    String body = notification?.body ?? data['body'] ?? 'No Body';

    //Android notification config
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      channelDescription: 'Notification channel for basic tests',
      priority: Priority.high,
      importance: Importance.high,
    );

    //iOS Notification config
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    //combine platform-specific settings
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    //show Notification
    await flutterLocalNotificationsPlugin.show(
      0, //notification id
      title,
      body,
      notificationDetails,
    );
  }

//Initilizes the local notification sysytem (both Android & iOS)
  static Future<void> _initizeLocalNotification() async {
    const AndroidInitializationSettings androidInit = AndroidInitializationSettings(
        '@drawable/ic_launcher'); //change any notification icon if you want , 1. (place icon- android-src-main-res-drawable-ic_launcher.png) 2. AndroidManifest.xml(<meta-data android:name="com.google.firebase.messaging.default_notification_icon" android:resource="@drawable/ic_launcher" />)

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      print("User Tapped Notification: ${response.payload}");
    });
  }

//Handle Notification tap when app is (terminated) get notification & if click go to App
  static Future<void> getInitialMessage(BuildContext context) async {
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      print(
          "App launched from terminated state via notification: ${message.data}");

      //create channel on androidmanifest file , get notification click and navigate to particular page if you pass
      if (message.data["page"] == "SeeAllItems") {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => SeeAllItems()),
        );
      }
    }
  }
}
