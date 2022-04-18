import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/token.dart';
import 'package:Zenith/validator/validate.dart';
import 'loading.dart';
import 'local_storage.dart';

Future<String?> getAccessToken() async {
  var token = await BasePrefs.readData(authToken);
  if(isValidString(token)){
    return token;
  }
  return null;
}

Future<int?> getUserId() async {
  var token = await BasePrefs.readData(userId);
  if(isValidString(token)){
    return int.parse(token);
  }
  return null;
}

Future<int?> getUserType() async {
  var token = await BasePrefs.readData(userType);
  if(isValidString(token)){
    return int.parse(token);
  }
  return null;
}

Future getLessonCache() async {
  var token = await BasePrefs.readData(lessonCache);
  if(isValidString(token)){
    return token;
  }
  return null;
}

Future getAddLessonCache() async {
  var token = await BasePrefs.readData(addLessonCache);
  if(isValidString(token)){
    return token;
  }
  return null;
}

Future<String?> getDeviceToken() async {
  String? token = await BasePrefs.readData(deviceToken);
  if(token!=null && token.isNotEmpty){
  }else if(token==null || token.isEmpty){
    if(await fcmTokenMonitor() !=null){
      fcmTokenMonitor().then((value) {
        if(value!=null){
          token = value;
        }
      });
    }else{
      token= null;
    }
  }
  return token;
}

Future<String?> getDeviceModel() async {
  var deviceInfo = new DeviceInfoPlugin();
  var model;
  if(Platform.isAndroid){
    var androidInfo = await deviceInfo.androidInfo;
     model = androidInfo.model;
  }else if(Platform.isIOS){
    var androidInfo = await deviceInfo.iosInfo;
     model = androidInfo.model;
  }else{
   model = null;
  }
  return model;
}

Future<String?> getDeviceVersion() async {
  var deviceInfo = new DeviceInfoPlugin();
  var model;
  if(Platform.isAndroid){
    var androidInfo = await deviceInfo.androidInfo;
    var sdkInt = androidInfo.version.sdkInt;
    var release = androidInfo.version.release;
    model= "Android $release (SDK $sdkInt)";
  }else if(Platform.isIOS){
    var iosInfo = await deviceInfo.iosInfo;
    var systemName = iosInfo.systemName;
    var version = iosInfo.systemVersion;
    model= "$systemName $version";
  }else{
    model = null;
  }
  return model;
}