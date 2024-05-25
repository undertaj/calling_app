

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Const {
  final String device_token = FirebaseMessaging.instance.getToken().toString();
  late final String device_model;

  Future<String> getDeviceModel() async{
    device_model  = (await DeviceInfoPlugin().androidInfo).model;
    return device_model;
  }
}