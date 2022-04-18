import 'dart:io';
import 'package:Zenith/provider/cartIcon.dart';
import 'package:Zenith/view_model/auth_view_model.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Zenith/helper/scroll_behavior.dart';
import 'package:Zenith/provider/theme.dart';
import 'package:Zenith/utils/routes.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'utils/locator.dart';
import 'view_model/course_view_model.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setLocator();
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeProvider()),
        ChangeNotifierProvider.value(value: UserViewModel.initializer()),
        ChangeNotifierProvider.value(value: AppViewModel.initializer()),
        ChangeNotifierProvider.value(value: CourseViewModel.initializer()),
        ChangeNotifierProvider.value(value: ClassViewModel.initializer()),
        ChangeNotifierProvider.value(value: CartViewModel.initializer()),
        ChangeNotifierProvider.value(value: AuthViewModel.initializer())
      ],
      child: new Consumer<ThemeProvider>(builder: (context, theme, child) {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MProvider(
              child: MaterialApp(
                builder: (context, child) {
                  return ScrollConfiguration(
                      behavior: MyBehavior(), child: child!);
                },
                initialRoute: "/",
                onGenerateRoute: Routes.onGenerateRoute,
                theme: theme.darkTheme,
                title: "Zenith Dance App",
                debugShowCheckedModeBanner: false,
              ),
            );
          });
        });
      })));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
