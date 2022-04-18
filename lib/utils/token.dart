import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'local_storage.dart';

Future<Map<String, String>> authHeader() async {
  Map<String, String> header;
  if (await BasePrefs.readData(authToken) != null) {
    var token = await BasePrefs.readData(authToken);

    header = {
      "Accept": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
  } else {
    header = {"Accept": "application/json"};
  }
  return header;
}
Future<String?> fcmTokenMonitor()async{
  String? status;
  Stream<String> _tokenStream;
  await FirebaseMessaging.instance.getToken().then((value) {
    if(value!=null && value.isNotEmpty){
      BasePrefs.saveData(deviceToken, value);
      status = value;
    }else{
      status = null;
    }
  });
  _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
  _tokenStream.listen((event) {
    if(event.isNotEmpty){
      BasePrefs.saveData(deviceToken, event);
      status = event;
    }else{
      status = null;
    }
  });
  return status;
}