


import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/const.dart';
import 'api.dart';

class AuthService {
   AuthService();


  // sign in with email and password
  Future<bool> signIn(String mobile, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String deviceToken = prefs.getString('deviceToken') ?? '';
      String deviceModel = prefs.getString('deviceModel') ?? '';
      prefs.setString("enc_key", 'CLoSs4xeEn4AQ4bpsB32LXSq3');

      if(kDebugMode){
        print('mobile: $mobile');
        print('password: $password');
        print('enc_key: CLoSs4xeEn4AQ4bpsB32LXSq3');
        print('device_token: $deviceToken');
        print('deviceModel: $deviceModel');
      }

      FormData data = FormData.fromMap(
      {
        'mobile': mobile,
        'password': password,
        'enc_key': 'CLoSs4xeEn4AQ4bpsB32LXSq3',
        'device_token': deviceToken,
        'device_model': deviceModel,
      });
      Response res = await Api.postRequest('Login', formData: data);

      if (kDebugMode) {
        print(res.data);
      }
      if(res.statusCode == 200) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('enc_id', res.data['enc_id']);
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }


  Future signOut() async {
    try {
      // return await .signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}