


import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../models/call_log_data_entry.dart';
import '../utils/const.dart';
import 'api.dart';

class CallLogService {
  CallLogService();


  // sign in with email and password
  Future<Response> sendData(CallLogData data) async {
    try {
      if (kDebugMode) {
        print('enc_id: ${data.encId}');
        print('enc_key: ${data.encKey}');
        print('device_token: ${data.deviceToken}');
        // print('call_data: ${data.callData.toString().substring(0, 100)}');
      }
      Map<String, dynamic> data1 = data.toJson();
      data1['call_data'] = jsonEncode(data1['call_data']);
      if (kDebugMode) {
        print(data1.toString().substring(100,1000));
      }
      FormData fdata = FormData.fromMap(data1);
      if (kDebugMode) {
        print("SENDING DATAAAAAA\n");
      }
      Response res = await Api.postRequest('Call-Log', formData: fdata);

      if (kDebugMode) {
        print("SENT\n");
        print(res.data);
      }
      return res;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Error();

    }
  }

}