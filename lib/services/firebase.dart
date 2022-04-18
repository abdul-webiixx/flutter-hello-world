import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseService {

  Future<void> firebaseSocketException({dynamic apiCall,dynamic userId,
    dynamic message, dynamic email}) async {
    await FirebaseCrashlytics.instance.recordError(
        "ApiCall:- $apiCall, UserId:- ${userId ?? null}, UserEmail:- $email", null,reason: "firebaseSocketException:- $message", fatal: false);
  }

  Future<void> firebaseFormatException({dynamic apiCall,dynamic userId, dynamic message, dynamic email}) async {
    await FirebaseCrashlytics.instance.recordError(
        "ApiCall:- $apiCall, UserId:- ${userId ?? null}, UserEmail:- $email", null,reason: "firebaseFormatException:- $message", fatal: false);
  }

  Future<void> firebaseHttpException({dynamic apiCall,dynamic userId, dynamic message, dynamic email}) async {
    await FirebaseCrashlytics.instance.recordError(
        "ApiCall:- $apiCall, UserId:- ${userId ?? null}, UserEmail:- $email", null,reason: "firebaseHttpException:- $message",  fatal: false);

  }

  Future<void> firebaseDioError({dynamic apiCall, dynamic userId, dynamic message, dynamic code, dynamic email}) async {
    await FirebaseCrashlytics.instance.recordError(
        "ApiCall:- $apiCall, UserId:- ${userId ?? null}, UserEmail:- $email", null,reason: "firebaseDioError:- $message",  fatal: false);

  }
  FutureOr<Null> firebaseJsonError({dynamic apiCall, dynamic userId, dynamic message, dynamic stackTrace}) async {
    await FirebaseCrashlytics.instance.recordError(
        "ApiCall:- $apiCall, UserId:- ${userId ?? null},", stackTrace,reason: "firebaseDioError:- $message",  fatal: false,
    );

  }

}