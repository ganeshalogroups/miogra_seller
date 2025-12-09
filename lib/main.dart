// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:miogra_seller/Constants/const_variables.dart';
// import 'package:miogra_seller/Controllers/InsightsController/OrdersController.dart';

// import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
// import 'package:miogra_seller/Screens/Menu/menuscreen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:miogra_seller/Screens/OrdersScreen/Ordesviewscreen.dart';

// import 'package:miogra_seller/firebase_option.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'Screens/AuthScreen/splash_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
//   await GetStorage.init();
//   await getFCMToken();
//   await FirebaseNotificationService.initialize();
//   await FirebaseNotificationService.initLocalNotifications();
//   FirebaseAnalytics analytics = FirebaseAnalytics.instance;

//   runApp(
//     const MyApp(),
//   );
// }

// Future<void> getFCMToken() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   // Retrieve the FCM token
//   String? token = await messaging.getToken();
//   tokenFCM = token.toString();
//   print("tokenfcm :${tokenFCM}");
//   if (token != null) {
//     print("FCM Token: $token");
//   } else {
//     print("Failed to get FCM Token");
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       splitScreenMode: true,
//       designSize:
//           const Size(360, 690), // Design size (width, height) for your app
//       minTextAdapt: true,
//       builder: (context, child) => ResponsiveApp(
//         builder: (BuildContext context) {
//           return MultiProvider(
//             providers: [
//               ChangeNotifierProvider(
//                   create: (context) => CategoryPaginations()),
//               ChangeNotifierProvider(
//                 create: (context) => MenuPagenations(),
//               ),
//                ChangeNotifierProvider(
//                 create: (context) => OrderviewPaginations(),
//               )
//             ],
//             child: GetMaterialApp(
//               title: 'FastX Restaurant',
//               theme: ThemeData(
//                 fontFamily: 'Poppins-Regular',
//                 colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//                 useMaterial3: true,
//               ),
//               debugShowCheckedModeBanner: false,
//               home: const SplashScreen(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class FirebaseNotificationService {
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     // Request notification permissions for iOS
//     await _requestPermission();

//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     FirebaseMessaging.onMessage.listen(_onMessageReceived);

//     FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);
//   }

//   // Request notification permissions (iOS-specific)
//   static Future<void> _requestPermission() async {
//     NotificationSettings settings =
//         await _firebaseMessaging.requestPermission();
//     print('User granted permission: ${settings.authorizationStatus}');
//   }

//   // Background message handler
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     print('Handling a background message: ${message.messageId}');
//   }

//   // Foreground message handler
//   static Future<void> _onMessageReceived(RemoteMessage message) async {
//     print('Received message: ${message.notification?.title}');
//     await _showLocalNotification(message);
//   }

//   // Handle messages when the app is opened from a notification
//   static Future<void> _onMessageOpened(RemoteMessage message) async {
//     print("📲 App opened via notification");
//     String? targetScreen = message.data['screen']; // Example key

//     if (targetScreen != null && targetScreen != "none") {
//       print("+++++++++++++++++++++++++++++++++++++++++++++");
//       print(targetScreen);
//       Get.to(() => Ordersviewscreen(
//             orderId: targetScreen.toString(),
//           ));
//     }
//     print('App opened from notification: ${message.notification?.title}');
//     String? route = message.data['route']; // Extract the route from data
//     if (route != null) {
//       Get.toNamed(route);
//     }
//   }

//   // Initialize local notifications
//   static Future<void> initLocalNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         print("+++++++++++++++++++++++++++++++++++++++++++++");
//         print(response);
//         print(response.payload);
//         String? targetScreen = response.payload;
//         if (targetScreen != null && targetScreen != "none") {
//           Get.to(() => Ordersviewscreen(
//                 orderId: targetScreen.toString(),
//               ));
//         }
//       },
//     );
//   }

//   // Show a local notification
//   static Future<void> _showLocalNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'your_channel_id', // Make sure to match this with AndroidManifest.xml
//       'Your Channel Name',
//       channelDescription: 'Your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidDetails);

//     await _flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//       payload: message.data['screen'], // Pass the route as the payload
//     );
//   }
// }






























import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
import 'package:miogra_seller/Screens/Menu/menuscreen.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/firebase_option.dart';
import 'package:miogra_seller/Screens/AuthScreen/splash_screen.dart';
import 'package:miogra_seller/Screens/OrdersScreen/Ordesviewscreen.dart';
import 'package:miogra_seller/Controllers/InsightsController/OrdersController.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


String? lastBgMessageId; // prevent duplicate background messages

Future<void> askNotificationPermission() async {
  final status = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    criticalAlert: true,
    provisional: false,
  );

  print("🔔 Notification Permission = ${status.authorizationStatus}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
 await askNotificationPermission();
  await GetStorage.init();
  await getFCMToken();

  
  await FirebaseNotificationService.initLocalNotifications();
  await FirebaseNotificationService.initialize();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(const MyApp());
}

Future<void> getFCMToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  tokenFCM = token.toString();
  print("FCM TOKEN: $tokenFCM");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => ResponsiveApp(
        builder: (_) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => CategoryPaginations()),
              ChangeNotifierProvider(create: (_) => MenuPagenations()),
             
              ChangeNotifierProvider(create: (_) => OrderviewPaginations()),
            ],
            child: GetMaterialApp(
              title: 'Miogra Seller',
              theme: ThemeData(
                fontFamily: 'Poppins-Regular',
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// 🔥 FIREBASE NOTIFICATION SERVICE WITH CUSTOM SOUND BELOW
//////////////////////////////////////////////////////////////

class FirebaseNotificationService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin
      _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
   // await _requestPermission();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpened);
  }

  // static Future<void> _requestPermission() async {
  //   final settings = await _firebaseMessaging.requestPermission();
  //   print("NOTIFICATION PERMISSION: ${settings.authorizationStatus}");
  // }




//  @pragma('vm:entry-point')
//   static Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//           await Firebase.initializeApp();
//     print("🔥 Background Message: ${message.messageId}");
//   }

@pragma('vm:entry-point')
static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  print("🔥 Background Message: ${message.messageId}");
  print(message.data);

  // Ignore image-prefetch or empty messages
  if (!message.data.containsKey("messageId") ||
      !message.data.containsKey("title") ||
      !message.data.containsKey("body")) {
    print("⚠️ Ignored image-prefetch/background utility message");
    return;
  }

  String messageId = message.data['messageId']!;

  // Duplicate protection
  if (lastBgMessageId == messageId) {
    print("🔁 Duplicate BACKGROUND notification skipped");
    return;
  }

  lastBgMessageId = messageId;

  print("🆕 New BACKGROUND message: $messageId");
}


  static Future<void> _onMessageReceived(RemoteMessage message) async {
    print("📩 Foreground Message Received");
    await _showLocalNotification(message);
  }

  static Future<void> _onMessageOpened(RemoteMessage message) async {
    print("📲 Notification Clicked");

    String? targetScreen = message.data['screen'];
    if (targetScreen != null && targetScreen != "none") {
      Get.to(() => Ordersviewscreen(orderId: targetScreen.toString()));
    }
  }

  // Initialize local notifications
  static Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidSettings);

    // Create custom channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
  'High Importance Notifications',
      description: 'Used for order alerts and important updates.',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('clock_alarm'),
      playSound: true,
    );

    // Register channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Initialize plugin
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        String? targetScreen = response.payload;
        if (targetScreen != null && targetScreen != "none") {
          Get.to(() => Ordersviewscreen(orderId: targetScreen.toString()));
        }
      },
    );
  }

  // Show notification with custom sound
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
       'high_importance_channel',
      'High Importance Notifications',
      channelDescription:  'Used for order alerts and important updates.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('clock_alarm'),
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0,
      message.notification?.title ?? "New Notification",
      message.notification?.body ?? "",
      platformDetails,
      payload: message.data['screen'],
    );
  }
}



















