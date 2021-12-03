import 'dart:async';
import 'dart:io';
import 'package:delivery_boy/Helper/LocationManager.dart';
import 'package:delivery_boy/Screens/TabBarScreens/DashboardScreen/DashboardScreen.dart';
import 'package:delivery_boy/Screens/TabBarScreens/TabBar/TabBarScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'Helper/SharedManaged.dart';
import 'Screens/LoginScreen/LoginScreen.dart';
import 'generated/i18n.dart';

//Local Push Notification setup

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });
  runApp(
    MyApp(),
  );
}

typedef ColorCallback = void Function(String color);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: SharedManager.shared.locale,
        builder: (context, Locale value, _) {
          print(value);
          return MaterialApp(
            // initialRoute:'/LoginPage',
            // onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            locale: value,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeListResolutionCallback:
                S.delegate.listResolution(fallback: const Locale('en', '')),
            color: Colors.blue,
            home: Splash(),
          );
        });
  }
}

class Splash extends StatefulWidget {
  const Splash({this.onColorSelect});

  final ColorCallback onColorSelect;

  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _showNotification(String title, String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$message', platformChannelSpecifics,
        payload: 'item x');
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _seen = prefs.getString('isLoogedIn');

    if (_seen == "yes") {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new TabBarScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginScreen()));
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    _requestIOSPermissions();
    super.initState();
    // FirebaseApp.initializeApp(this);
    getLocation();

    new Timer(new Duration(milliseconds: (Platform.isAndroid ? 2000 : 100)),
        () {
      checkFirstSeen();
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
        SharedManager.shared.isNotificationComes = true;
        final message1 = message['notification']['body'];
        final title = message['notification']['title'];
        print("Notification Message:$message1");
        DashboardScreen().method();

        // this.widget.onColorSelect("hello");
        //  notifier.notify('action', "true");
        //  SharedManager.shared.isNotificationComes = false;
        // Vibration.vibrate(duration: 1000);
        setViebarteMode();
        //if (Platform.isAndroid) {
        displayTostForNotification(message1);
        // if (Platform.isAndroid) {
        // displayTostForNotification(message1);
        _showNotification(title, message1);
        // }
        //  }
        return;
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      print(token);
      SharedManager.shared.token = token;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString(token,DefaultKeys.pushToken);
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    /*Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );*/
  }

  displayTostForNotification(String message) async {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }

  setViebarteMode() async {
    HapticFeedback.vibrate();
  }

  getLocation() async {
    await LocationManager.shared.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: Platform.isAndroid
              ? new Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(75),
                      image: DecorationImage(
                          image: AssetImage('Assets/images/foodTruck.png'),
                          fit: BoxFit.fill)),
                )
              : new Text('')),
    );
  }
}
