import 'dart:async';
import 'dart:ui';


import 'package:call_log/call_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
List<CallLogEntry> newEntry = [];

@pragma('vm:entry-point')
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>;
  await service.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
        onStart: onStart, isForegroundMode: true, autoStart: true),
  );
}

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsBackgroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  final cj = await CallLog.get();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // final cookies = await cj.loadForRequest(Uri.parse(Const.apiUrl));
  // final isAuthenticated = cookies.isNotEmpty;
  Timer.periodic(Duration(seconds: 60), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: 'Lead Hornet', content: 'Tap to view more');
      }
    }
    WidgetsFlutterBinding.ensureInitialized();
    try {
      final cj = await CallLog.get();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(cj.length != prefs.getKeys().length) {
        int x = cj.length - prefs.getKeys().length;
        newEntry = cj.toList().sublist(cj.length - x);
        for(var entry in newEntry) {
          prefs.setStringList('@${entry.timestamp}', ['${entry.number}', '${entry.name}', '${entry.callType}', '${entry.timestamp}', '${entry.duration}', '${entry.cachedMatchedNumber}',  '${entry.cachedNumberLabel}', '${entry.cachedNumberType}', '${entry.formattedNumber}', '${entry.phoneAccountId}', '${entry.simDisplayName}']);
        }
      }
      // final cookies = await cj.loadForRequest(Uri.parse(Const.apiUrl));
      // final isAuthenticated = cookies.isNotEmpty;
      // if (isAuthenticated) {
      //   List<OnlineOrder> orderHistory = [];
      //
      //   orderHistory = await OrderServices.orderHistory();
      //   orderHistory = orderHistory.reversed.toList();
      //
      //   print(orderHistory.length);
      //   pendingData = orderHistory
      //       .where((element) =>
      //   element.items![0].status == "PENDING".toLowerCase())
      //       .toList();
      //   // print(pendingData.length);
      //   if (pendingData.length > 0) {
      //     scheduleAlarm('New order is available',
      //         'Order id - ' + pendingData[0].orderId.toString());
      //   }

        print('background service running');
      // }
    } catch (e) {
      print("EXCEPTION: $e");
    }
  });
}

Future<void> scheduleAlarm(String newOrder, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id1',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound('telephone_ring'),
    enableVibration: true,
    playSound: true,
  );

  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  flutterLocalNotificationsPlugin.show(
      0, newOrder, body, platformChannelSpecifics);
}
