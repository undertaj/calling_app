
import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:caller_app/models/call_log_data_entry.dart';
import 'package:caller_app/view/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/callLog_service.dart';
import 'widgets/contacts_body.dart';
import 'widgets/recent_body.dart';
import 'widgets/sliver_list.dart';
import 'chat_page.dart';


// {entry.formattedNumber}', ),
// {entry.cachedMatchedNumber}', ),
// {entry.number}', ),
// {entry.name}',),
// {entry.callType}', ),
// {DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',),
// {entry.duration}', ),
// {entry.phoneAccountId}', ),
// {entry.simDisplayName}', ),



class HomeEpigle extends StatefulWidget {
  const HomeEpigle({super.key});

  @override
  State<HomeEpigle> createState() => _HomeEpigleState();
}
class _HomeEpigleState extends State<HomeEpigle> with SingleTickerProviderStateMixin {
  int selectedIndex = 6;
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation _animation;
  List<CallLogEntry> callLogEntries= [];
  List<List<CallLogEntry>> groups= [];
  List<Map<String, List<CallLogEntry>>> groups1 = [];
  final GlobalKey _tweenKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = 0;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),

    );
    // _animation = Tween<Offset>(
    //   begin: const Offset(0.0, -1.0), // Start position (top)
    //   end: const Offset(0.0, 0.0),    // End position (center)
    // ).animate(_controller);
    getCalls();
    print("Call log entries length = ${callLogEntries.length}");
    // _controller.forward(from: 0.7);
    // init();
    super.initState();
  }

  void getCalls() async {
    callLogEntries = (await CallLog.get()).toList();
    // for(int i= 0; i < 0; i++) {
    //   var entry = callLogEntries[i];
    //   if(kDebugMode) {
    //     print('-------------------------------------');
    //     print('F. NUMBER  : ${entry.formattedNumber}');
    //     print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
    //     print('NUMBER     : ${entry.number}');
    //     print('NAME       : ${entry.name}');
    //     print('TYPE       : ${entry.callType}');
    //     print('DATE       : ${DateTime.fromMillisecondsSinceEpoch(
    //         entry.timestamp!)}');
    //     print('DURATION   : ${entry.duration}');
    //     print('ACCOUNT ID : ${entry.phoneAccountId}');
    //     print('ACCOUNT ID : ${entry.phoneAccountId}');
    //     print('SIM NAME   : ${entry.simDisplayName}');
    //
    //     print('-------------------------------------');
    //   }
    // }
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(!pref.containsKey("count")) {
      pref.setString("count", callLogEntries.length.toString());
    }

    String count = (pref.getString("count")!);
    if (kDebugMode) {
      print(DateTime.fromMillisecondsSinceEpoch(callLogEntries[0].timestamp!).toString());
    }
    if(true) {
      pref.setString("count", callLogEntries.length.toString());
      List<CallDatum> callDatumList = [];
      int i = 0;
      for(CallLogEntry entry in callLogEntries) {
        if(i == 5) break;
        callDatumList.add(CallDatum(
            callFrom: entry.callType == CallType.incoming || entry.callType == CallType.missed
                ? entry.number.toString().substring(3)
                : "number",
            fromCode: entry.callType == CallType.incoming || entry.callType == CallType.missed
                ? entry.number.toString().substring(0,3)
                : "number",
            callTo: entry.number.toString().substring(3),
            toCode: entry.number.toString().substring(0,3),

            type: (entry.callType != CallType.missed) ? entry.callType.toString() : "missed-call",
            callTiming: DateTime.fromMillisecondsSinceEpoch(entry.timestamp!).toString(),
            startTime: DateTime.fromMillisecondsSinceEpoch(entry.timestamp!).toString(),
            endTime: DateTime.fromMillisecondsSinceEpoch(entry.timestamp! + entry.duration!).toString()
        ));
        i++;
      }
      String encId = pref.getString("enc_id")!;
      String encKey = pref.getString("enc_key")!;
      String deviceToken = pref.getString("deviceToken")!;
      CallLogData calldata = CallLogData(
          encId: encId,
          encKey: encKey,
          deviceToken: deviceToken,
          callData: callDatumList
      );
      await CallLogService().sendData(calldata);
    }




    int k = 1;
    if(k == 1) {
      k = 0;
      print("First Entry:");
      print('${callLogEntries[0].name!}  ----- ${callLogEntries[0]
          .number!} -----  ${DateTime.fromMicrosecondsSinceEpoch(
          callLogEntries[0].timestamp!)} -----  ${callLogEntries[0].callType}');
    }
    groupCalls();
    saveCalls();
    // setState(() {});
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ),);
  }

  void saveCalls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // for (var entry in callLogEntries) {
    //   prefs.setStringList('@${entry.timestamp}', ['${entry.number}', '${entry.name}', '${entry.callType}', '${entry.timestamp}', '${entry.duration}', '${entry.cachedMatchedNumber}',  '${entry.cachedNumberLabel}', '${entry.cachedNumberType}', '${entry.formattedNumber}', '${entry.phoneAccountId}', '${entry.simDisplayName}']);
    // }
  }
  void groupCalls()   {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, List<CallLogEntry>> keyMap = {};

    for (var entry in callLogEntries) {
      // prefs.setStringList('@${entry.timestamp}', ['${entry.number}', '${entry.name}', '${entry.callType}', '${entry.timestamp}', '${entry.duration}', '${entry.cachedMatchedNumber}',  '${entry.cachedNumberLabel}', '${entry.cachedNumberType}', '${entry.formattedNumber}', '${entry.phoneAccountId}', '${entry.simDisplayName}']);

      // Check if name is null

      var date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
      // while((k++)<30) {
      //   print("Name + date ${entry.name} ${date}");
      // }
      String key = '${entry.number}_${date.year}-${date.month}-${date.day}';
      if(keyMap.containsKey(key)) {
        // if(k < 15) {
        //   if (kDebugMode) {
        //     print("${entry.name ??
        //       ""}   $key added  - - - - - - - - - - - - - -  ${getTime(
        //       date)}   $k");
        //   }
        // }
        // k++;
        keyMap[key]!.add(entry);
      }
      else {
        keyMap[key] = [entry];
      }
    }
    groups = keyMap.values.toList();
  }

  void groupByCalls(){
    Map<String, Map<String, List<CallLogEntry>>> keyMap = {};
    int k = 0;
    for (var entry in callLogEntries) {
      var date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
      String key = '${date.year}/${date.month}/${date.day}';
      if(keyMap.containsKey(key)) {
        String number = entry.number.toString();
        if(keyMap[key]!.containsKey(number)) {
          keyMap[key]?[number]!.add(entry);
        }
        else {
          keyMap[key]?[number] = [entry];
        }
      }
      else {
        keyMap[key] = {entry.number.toString() :  [entry]};
      }
    }
    groups1 = keyMap.values.toList();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  String? getTime(DateTime time) {
    int h = time.hour;
    int m = time.minute;
    if(h >= 12) {
      if(h != 12) {
        h-= 12;
      }

      return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m PM";
    }
    else {
      if(h == 0) {
        h+=12;
      }
      return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m AM";
    }
  }

  Widget _buildIconButton({required Widget icon, required int index}) {
    final double totalIcons = 8; // Change this to the total number of icons
    final double radius = MediaQuery.of(context).size.width * 0.88 / 2.59;


    // Animation am = Tween<double>(begin:  (index -1), end: index.toDouble() ).animate(_controller);
    // CurvedAnimation _c = CurvedAnimation( parent: _controller, curve: Curves.easeIn);


    return TweenAnimationBuilder(
      // key: _tweenKey,


      curve: Curves.easeIn,
      tween: Tween<double>(begin:  (index - 1), end: index.toDouble() ),
      duration:  Duration(seconds: 5),
      builder : (context, _ , child) {
        double angle = 2 * pi * (selectedIndex - _ - 2) / totalIcons;
        // double animValue = Curves.easeInOutBack.transform(_controller.value);
        double offsetX = 0 + radius * cos(angle );
        double offsetY = 0 + radius * sin(angle );

        return Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: IconButton(
            iconSize: 14,
            onPressed: () {
              // _c.drive(CurveTween(curve: Curves.easeIn));
              setState(() {
                // _controller.forward(from: 0);
              });
              // _controller.forward(from: 0.7);


              selectedIndex = index;

              // setState(() {
              //   selectedIndex = index;
              //   // Maybe you don't need to call _controller.forward again here
              // });
            },
            icon: icon,
          ),
        );
      }
    );
  }

  // Widget _buildIconButton({required Widget icon, required int index}) {
  //   // print("Index = $index SleectedIndex = $selectedIndex");
  //   int x = (selectedIndex - index);
  //
  //   print("X = $x");
  //   final double angle = 2 * pi * (x-2) / 8;
  //   // print("X=$x Angle=$angle");
  //   final double radius = MediaQuery.of(context).size.width * 0.88 / 2.59;
  //   print("Offset = ${radius * cos(angle)} ${radius * sin(angle)}");
  //   final double offsetX = 0 + radius * cos(angle);
  //   final double offsetY = 0 + radius * sin(angle);
  //   final double angle2 = 2 * pi * (index) / 8;
  //   print("Offset = ${radius * cos(angle2)} ${radius * sin(angle2)}");
  //   final double offsetX2 = 0 + radius * cos(angle2);
  //   final double offsetY2 = 0 + radius * sin(angle2);
  //
  //
  //   return
  //
  //     Transform.translate(
  //
  //       offset: Offset(
  //           radius*cos(angle),radius*sin(angle)
  //       ),
  //       child: IconButton(
  //         iconSize: 14,
  //         // style: ElevatedButton.styleFrom(
  //         //   padding: EdgeInsets.all(20)
  //         //
  //         // ),
  //
  //
  //
  //
  //         onPressed: () {
  //           selectedIndex = index;
  //           _controller.forward(from: 0.7);
  //           setState(() {
  //             _controller.forward(from: 0.7);
  //           });
  //           // _controller.animateTo(1, curve: Curves.easeIn);
  //           // _controller.animateTo(1, curve: Curves.easeIn);
  //           // if (index % 3 == 0) {
  //           //   _currentIndex = 0;
  //           //   // _pageController.jumpToPage(0);
  //           // }
  //           // else if (index % 3 == 1) {
  //           //   _currentIndex = 1;
  //           //   // _pageController.jumpToPage(1);
  //           // }
  //           // else {
  //           //   _currentIndex = 2;
  //           //   // _pageController.jumpToPage(2);
  //           // }
  //           //   print("Selected Index = $selectedIndex");
  //           //   print("----------------SET STATED---------\n\n");
  //           // });
  //         },
  //         icon: icon,
  //       ),
  //     );
  // }



  List<String> iconType = ["chat", "home", "call"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:


      Stack(
        children: [
          // Container(
          //   color: Colors.white,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(height: 20,),
          //       (0 == 0)  ?
          //       IconButton(
          //         icon: SvgPicture.asset(
          //           'assets/icons/menu.svg',
          //           // height: 40,
          //           // width: 40,
          //         ),
          //         onPressed: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfilePage()));
          //         },
          //       )
          //           : (
          //           _currentIndex == 1 ?
          //           IconButton(
          //             padding: EdgeInsets.zero,
          //             icon: SvgPicture.asset(
          //               'assets/icons/back_icon.svg',
          //               height: 20,
          //               width: 20,
          //             ),
          //             onPressed: () {
          //             },
          //           ) :
          //           IconButton(
          //             // padding: EdgeInsets.zero,
          //             icon: SvgPicture.asset(
          //               'assets/icons/menu.svg',
          //               // height: 40,
          //               // width: 40,
          //             ),
          //             onPressed: () {},
          //           )
          //       ),
          //       0 == 0 ?
          //       Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 15),
          //         child: Column(
          //           // crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             TextField(
          //               decoration: InputDecoration(
          //                 contentPadding: const EdgeInsets.only(bottom: 9),
          //                 labelText: 'Recent Calls',
          //                 labelStyle: const TextStyle(
          //                   fontSize: 24,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //                 hintText: '',
          //                 fillColor: Colors.white,
          //                 filled: true,
          //                 suffixIcon: IconButton(
          //                   icon: SvgPicture.asset(
          //                     'assets/icons/search.svg',
          //                     height: 16.8,
          //                     width: 16.17,
          //                   ),
          //                   onPressed: () {},
          //                 ),
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(30),
          //                   borderSide: BorderSide.none,
          //                 ),
          //               ),
          //             ),
          //             const SizedBox(height: 6,),
          //             const Divider(
          //               height: 0.31,
          //               color: Color(0xff9B98A4),
          //             ),
          //             const SizedBox(height: 8,),
          //             Container(
          //                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(25),
          //                   color: const Color(0xffE7E6EE),
          //                 ),
          //                 child: const Text(
          //                   "Today",
          //                   // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                   ),
          //                 )),
          //           ],
          //         ),
          //       ) :
          //       (
          //           _currentIndex == 1 ?
          //           Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //             child: Column(
          //               children: [
          //                 Container(
          //
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       const Row(
          //                         children: [
          //                           CircleAvatar(
          //                             radius: 36.39/2,
          //                             backgroundImage: AssetImage('assets/images/face2.jpg'),
          //
          //                           ),
          //                           Padding(
          //                             padding: EdgeInsets.only(left: 12.75),
          //                             child: Text('Karthick',
          //                               style: TextStyle(
          //                                 fontSize: 24,
          //                                 fontWeight: FontWeight.w500,
          //                                 color: Color(0xff484554),
          //                                 letterSpacing: 0.13,
          //                               ),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                       IconButton(
          //                         icon: SvgPicture.asset(
          //                           'assets/icons/search.svg',
          //                           height: 16.8,
          //                           width: 16.17,
          //                         ),
          //                         onPressed: () {},
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 const SizedBox(height: 6,),
          //                 const Divider(
          //                   height: 0.31,
          //                   color: Color(0xff9B98A4),
          //                 )
          //               ],
          //             ),
          //           ) :
          //           Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //             child: Column(
          //               children: [
          //                 TextField(
          //                   decoration: InputDecoration(
          //                     contentPadding: const EdgeInsets.only(bottom: 9),
          //                     hintText: 'Contacts List',
          //                     hintStyle: const TextStyle(
          //                       fontSize: 24,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                     fillColor: Colors.white,
          //                     filled: true,
          //                     suffixIcon: IconButton(
          //                       icon: SvgPicture.asset(
          //                         'assets/icons/search.svg',
          //                         height: 16.8,
          //                         width: 16.17,
          //                       ),
          //                       onPressed: () {},
          //                     ),
          //                     border: OutlineInputBorder(
          //                       borderRadius: BorderRadius.circular(30),
          //                       borderSide: BorderSide.none,
          //                     ),
          //                   ),
          //                 ),
          //                 const SizedBox(height: 6,),
          //                 const Divider(
          //                   height: 0.31,
          //                   color: Color(0xff9B98A4),
          //                 )
          //               ],
          //             ),
          //           )
          //       ),
          //
          //
          //     ]
          //   )
          // ),
          FutureBuilder(

            future: CallLog.get(),
            builder: (context, snapshot) {

            return CustomScrollView(
              slivers:[
                SliverAppBar(
                  // title: Text('Hello'),
                  pinned: true,
                  floating: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  expandedHeight: 150,
                  // collapsedHeight: 60,
                  // collapsedHeight: 40, //70 for only recent calls

                  surfaceTintColor: Colors.white,
                  toolbarHeight: 84,
                  leading:
                  (0 == 0)  ?
                  IconButton(

                    icon: SvgPicture.asset(
                      'assets/icons/menu.svg',
                      // height: 40,
                      // width: 40,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfilePage()));
                    },
                  ) : (
                      _currentIndex == 1 ?
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          'assets/icons/back_icon.svg',
                          height: 20,
                          width: 20,
                        ),
                        onPressed: () {
                        },
                      ) :
                      IconButton(
                        // padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          'assets/icons/menu.svg',
                          // height: 40,
                          // width: 40,
                        ),
                        onPressed: () {},
                      )
                  ),
                  bottom:
                  PreferredSize(
                    preferredSize: const Size.fromHeight(110),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(bottom: 9),
                              labelText: 'Recent Calls',
                              labelStyle: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              hintText: 'Search for a number',
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/icons/search.svg',
                                  height: 16.8,
                                  width: 16.17,
                                ),
                                onPressed: () {},
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6,),
                          const Divider(
                              height: 0.31,
                              color: Color(0xff9B98A4),
                            ),

                          const SizedBox(height: 8,),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffE7E6EE),
                              ),
                              child: const Text(
                                "Today",
                                // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                if(snapshot.connectionState == ConnectionState.done)
                  SliverListT(groups: groups,)
                else
                  SliverToBoxAdapter(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 160,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
              ]
            );}
          ),
          // Positioned(
          //   top: 160,
          //   left: 0,
          //   child: Container(
          //     height: MediaQuery.of(context).size.height - 100,
          //     width: MediaQuery.of(context).size.width,
          //     child: FutureBuilder (
          //       future: CallLog.get(),
          //       builder:
          //           ( context,snapshot) {
          //         print("SNAPSHOT DATA");
          //         print(snapshot.data);
          //         groupCalls();
          //         print(groups);
          //         if(snapshot.connectionState == ConnectionState.done) {
          //           List<String> icon_type = ["chat", "home", "call"];
          //           callLogEntries = snapshot.data!.toList();
          //           if (callLogEntries.isEmpty) {
          //             return const Center(child: CircularProgressIndicator(),);
          //           } else {
          //             // return Center(child: Text("Hoola"),);
          //             return [
          //               RecentsBody(groups:  groups,),
          //               // ChatsBody(),
          //               const ChatsBody(),
          //               ContactsBody(),
          //             ][0];
          //           }
          //         }else {
          //           return const Center(child: CircularProgressIndicator(),);
          //         }
          //       },
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 0,
          //   child: AppBar(
          //     // title: Text('Hello'),
          //     // pinned: true,
          //     toolbarHeight: 64,
          //     leading:
          //     (0 == 0)  ?
          //     Padding(
          //       padding: EdgeInsets.all(33),
          //       child: IconButton(
          //
          //         icon: SvgPicture.asset(
          //           'assets/icons/menu.svg',
          //           // height: 40,
          //           // width: 40,
          //         ),
          //         onPressed: () {
          //           Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfilePage()));
          //         },
          //       ),
          //     ) : (
          //         _currentIndex == 1 ?
          //         IconButton(
          //           padding: EdgeInsets.zero,
          //           icon: SvgPicture.asset(
          //             'assets/icons/back_icon.svg',
          //             height: 20,
          //             width: 20,
          //           ),
          //           onPressed: () {
          //           },
          //         ) :
          //         IconButton(
          //           // padding: EdgeInsets.zero,
          //           icon: SvgPicture.asset(
          //             'assets/icons/menu.svg',
          //             // height: 40,
          //             // width: 40,
          //           ),
          //           onPressed: () {},
          //         )
          //     ),
          //     // bottom: 0 == 0 ?
          //     // PreferredSize(
          //     //   preferredSize: const Size.fromHeight(50),
          //     //   child: Container(
          //     //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     //     child: Column(
          //     //       // crossAxisAlignment: CrossAxisAlignment.start,
          //     //       children: [
          //     //         TextField(
          //     //           decoration: InputDecoration(
          //     //             contentPadding: const EdgeInsets.only(bottom: 9),
          //     //             labelText: 'Recent Calls',
          //     //             labelStyle: const TextStyle(
          //     //               fontSize: 24,
          //     //               fontWeight: FontWeight.w500,
          //     //             ),
          //     //             hintText: '',
          //     //             fillColor: Colors.white,
          //     //             filled: true,
          //     //             suffixIcon: IconButton(
          //     //               icon: SvgPicture.asset(
          //     //                 'assets/icons/search.svg',
          //     //                 height: 16.8,
          //     //                 width: 16.17,
          //     //               ),
          //     //               onPressed: () {},
          //     //             ),
          //     //             border: OutlineInputBorder(
          //     //               borderRadius: BorderRadius.circular(30),
          //     //               borderSide: BorderSide.none,
          //     //             ),
          //     //           ),
          //     //         ),
          //     //         const SizedBox(height: 6,),
          //     //         const Divider(
          //     //           height: 0.31,
          //     //           color: Color(0xff9B98A4),
          //     //         ),
          //     //         const SizedBox(height: 8,),
          //     //         Container(
          //     //             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          //     //             decoration: BoxDecoration(
          //     //               borderRadius: BorderRadius.circular(25),
          //     //               color: const Color(0xffE7E6EE),
          //     //             ),
          //     //             child: const Text(
          //     //               "Today",
          //     //               // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
          //     //               style: TextStyle(
          //     //                 color: Colors.black,
          //     //                 fontSize: 14,
          //     //               ),
          //     //             )),
          //     //       ],
          //     //     ),
          //     //   ),
          //     // ) :
          //     // (
          //     //     _currentIndex == 1 ?
          //     //     PreferredSize(
          //     //       preferredSize: const Size.fromHeight(50),
          //     //       child: Container(
          //     //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     //         child: Column(
          //     //           children: [
          //     //             Container(
          //     //
          //     //               child: Row(
          //     //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     //                 children: [
          //     //                   const Row(
          //     //                     children: [
          //     //                       CircleAvatar(
          //     //                         radius: 36.39/2,
          //     //                         backgroundImage: AssetImage('assets/images/face2.jpg'),
          //     //
          //     //                       ),
          //     //                       Padding(
          //     //                         padding: EdgeInsets.only(left: 12.75),
          //     //                         child: Text('Karthick',
          //     //                           style: TextStyle(
          //     //                             fontSize: 24,
          //     //                             fontWeight: FontWeight.w500,
          //     //                             color: Color(0xff484554),
          //     //                             letterSpacing: 0.13,
          //     //                           ),
          //     //                         ),
          //     //                       ),
          //     //                     ],
          //     //                   ),
          //     //                   IconButton(
          //     //                     icon: SvgPicture.asset(
          //     //                       'assets/icons/search.svg',
          //     //                       height: 16.8,
          //     //                       width: 16.17,
          //     //                     ),
          //     //                     onPressed: () {},
          //     //                   ),
          //     //                 ],
          //     //               ),
          //     //             ),
          //     //             const SizedBox(height: 6,),
          //     //             const Divider(
          //     //               height: 0.31,
          //     //               color: Color(0xff9B98A4),
          //     //             )
          //     //           ],
          //     //         ),
          //     //       ),
          //     //     ) :
          //     //     PreferredSize(
          //     //       preferredSize: const Size.fromHeight(50),
          //     //       child: Container(
          //     //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     //         child: Column(
          //     //           children: [
          //     //             TextField(
          //     //               decoration: InputDecoration(
          //     //                 contentPadding: const EdgeInsets.only(bottom: 9),
          //     //                 hintText: 'Contacts List',
          //     //                 hintStyle: const TextStyle(
          //     //                   fontSize: 24,
          //     //                   fontWeight: FontWeight.w500,
          //     //                 ),
          //     //                 fillColor: Colors.white,
          //     //                 filled: true,
          //     //                 suffixIcon: IconButton(
          //     //                   icon: SvgPicture.asset(
          //     //                     'assets/icons/search.svg',
          //     //                     height: 16.8,
          //     //                     width: 16.17,
          //     //                   ),
          //     //                   onPressed: () {},
          //     //                 ),
          //     //                 border: OutlineInputBorder(
          //     //                   borderRadius: BorderRadius.circular(30),
          //     //                   borderSide: BorderSide.none,
          //     //                 ),
          //     //               ),
          //     //             ),
          //     //             const SizedBox(height: 6,),
          //     //             const Divider(
          //     //               height: 0.31,
          //     //               color: Color(0xff9B98A4),
          //     //             )
          //     //           ],
          //     //         ),
          //     //       ),
          //     //     )
          //     ),
          //
          //   ),
          //
          // Positioned(
          //   // top: 64,
          //   // left: 30,
          //   bottom: MediaQuery.of(context).size.height - (64*2),
          //   child: Container(
          //
          //
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     child: Column(
          //       // crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         TextField(
          //           decoration: InputDecoration(
          //             contentPadding: const EdgeInsets.only(bottom: 9),
          //             labelText: 'Recent Calls',
          //             labelStyle: const TextStyle(
          //               fontSize: 24,
          //               fontWeight: FontWeight.w500,
          //             ),
          //             hintText: '',
          //             fillColor: Colors.white,
          //             filled: true,
          //             suffixIcon: IconButton(
          //               icon: SvgPicture.asset(
          //                 'assets/icons/search.svg',
          //                 height: 16.8,
          //                 width: 16.17,
          //               ),
          //               onPressed: () {},
          //             ),
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(30),
          //               borderSide: BorderSide.none,
          //             ),
          //           ),
          //         ),
          //         const SizedBox(height: 6,),
          //         const Divider(
          //           height: 0.31,
          //           color: Color(0xff9B98A4),
          //         ),
          //         const SizedBox(height: 8,),
          //         Container(
          //             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(25),
          //               color: const Color(0xffE7E6EE),
          //             ),
          //             child: const Text(
          //               "Today",
          //               // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 14,
          //               ),
          //             )),
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 64,
          //
          //   child: FutureBuilder (
          //     future: CallLog.get(),
          //     builder:
          //         ( context,snapshot) {
          //       print("SNAPSHOT DATA");
          //       print(snapshot.data);
          //       groupCalls();
          //       print(groups);
          //       if(snapshot.connectionState == ConnectionState.done) {
          //         List<String> icon_type = ["chat", "home", "call"];
          //         callLogEntries = snapshot.data!.toList();
          //         if (callLogEntries.isEmpty) {
          //           return const Center(child: CircularProgressIndicator(),);
          //         } else {
          //           // return Center(child: Text("Hoola"),);
          //           return [
          //             RecentsBody(groups:  groups,),
          //             // ChatsBody(),
          //             const ChatsBody(),
          //             ContactsBody(),
          //           ][0];
          //         }
          //       }else {
          //         return const Center(child: CircularProgressIndicator(),);
          //       }
          //     },
          //   ),
          // ),
          ///
          // Positioned(
          //   left: MediaQuery.of(context).size.width * 0.07,
          //   right: MediaQuery.of(context).size.width * 0.07,
          //   bottom: -((MediaQuery.of(context).size.width * 0.86)* 0.71),
          //   // bottom: 0,
          //   child: Container(
          //
          //     width: MediaQuery.of(context).size.width * 0.88,
          //     height: MediaQuery.of(context).size.width * 0.88,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Color(0xffE7E6EE),
          //     ),
          //     child:
          //     Padding(
          //       padding:EdgeInsets.only(left: MediaQuery.of(context).size.width/2.6, top: MediaQuery.of(context).size.width/2.6),
          //       child: Stack(
          //           children: [
          //             for(int index = 0; index < 8; index++)
          //               _buildIconButton(
          //                   icon: SvgPicture.asset(
          //                       'assets/icons/${iconType[index %
          //                           3]}_nav.svg'),
          //                   index: index)
          //           ]
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
            bottom: -((MediaQuery.of(context).size.width * 0.86)* 0.71),
            // bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.width * 0.88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE7E6EE),
              ),
              child:
              Padding(
                padding: const EdgeInsets.only(left : 140, top:  140),
                child: Stack(
                    children: [
                      for(int index = 0; index < 8; index++)
                        _buildIconButton(
                            icon: SvgPicture.asset(
                                'assets/icons/${iconType[index %
                                    3]}_nav.svg'),
                            index: index)
                    ]
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width/3,
            right: MediaQuery.of(context).size.width/3,
            child: SvgPicture.asset('assets/images/nav_bar_pointer.svg'),
          )
        ],
      ),


    );

  }
}

