
import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:caller_app/view/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'bodies/contacts_body.dart';
import 'bodies/recent_body.dart';
import 'chat_page.dart';


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

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = 0;


    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),

    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Start position (top)
      end: const Offset(0.0, 0.0),    // End position (center)
    ).animate(_controller);
    getCalls();
    print("Call log entries length = ${callLogEntries.length}");


    _controller.forward(from: 0.7);
    // init();
    super.initState();
  }
  void getCalls() async {
    callLogEntries = (await CallLog.get()).toList();
    int k = 0;
    while((k++) < 40)
    print('${callLogEntries[0].name!}  ----- ${callLogEntries[0].number!} -----  ${DateTime.fromMicrosecondsSinceEpoch(callLogEntries[0].timestamp!)} -----  ${callLogEntries[0].callType}');
    groupCalls();
    // setState(() {});
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ),);
  }

  void groupCalls(){
    Map<String, List<CallLogEntry>> keyMap = {};
    int k = 0;
    for (var entry in callLogEntries) {
      // Check if name is null

      var date = DateTime.fromMillisecondsSinceEpoch(entry.timestamp!);
      while((k++)<30) {
        print("Name + date ${entry.name} ${date}");
      }
      String key = '${entry.number}_${date.year}-${date.month}-${date.day}';
      if(keyMap.containsKey(key)) {
        keyMap[key]?.add(entry);
      }
      else {
        keyMap[key] = [];
      }
    }
    groups = keyMap.values.toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }


  Widget _buildIconButton({required Widget icon, required int index}) {
    // print("Index = $index SleectedIndex = $selectedIndex");
    int x = (selectedIndex - index);

    print("X = $x");
    final double angle = 2 * pi * (x-2) / 8;
    // print("X=$x Angle=$angle");
    final double radius = MediaQuery.of(context).size.width * 0.88 / 2.59;
    print("Offset = ${radius * cos(angle)} ${radius * sin(angle)}");
    final double offsetX = 0 + radius * cos(angle);
    final double offsetY = 0 + radius * sin(angle);
    final double angle2 = 2 * pi * (index) / 8;
    print("Offset = ${radius * cos(angle2)} ${radius * sin(angle2)}");
    final double offsetX2 = 0 + radius * cos(angle2);
    final double offsetY2 = 0 + radius * sin(angle2);


    return

      Transform.translate(

        offset: Offset(
            radius*cos(angle*_controller.value),radius*sin(angle*_controller.value)
        ),
        child: IconButton(
          iconSize: 14,
          // style: ElevatedButton.styleFrom(
          //   padding: EdgeInsets.all(20)
          //
          // ),




          onPressed: () {
            selectedIndex = index;
            _controller.forward(from: 0);
            // setState(() {
            //   _controller.forward(from: 0);
            // _controller.animateTo(1, curve: Curves.easeIn);
            // _controller.animateTo(1, curve: Curves.easeIn);
            // if (index % 3 == 0) {
            //   _currentIndex = 0;
            //   // _pageController.jumpToPage(0);
            // }
            // else if (index % 3 == 1) {
            //   _currentIndex = 1;
            //   // _pageController.jumpToPage(1);
            // }
            // else {
            //   _currentIndex = 2;
            //   // _pageController.jumpToPage(2);
            // }
            //   print("Selected Index = $selectedIndex");
            //   print("----------------SET STATED---------\n\n");
            // });
          },
          icon: icon,
        ),
      );
  }



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
                  // pinned: true,
                  floating: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  // expandedHeight: 50,
                  collapsedHeight: 100, //70 for only recent calls

                  surfaceTintColor: Colors.white,
                  toolbarHeight: 64,
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
                    preferredSize: const Size.fromHeight(50),
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
                              hintText: '',
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
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xffE7E6EE),
                              ),
                              child: const Text(
                                "Today",
                                // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
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


              Align(
                alignment: Alignment.center,
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

class SliverListT extends StatelessWidget {
  final List<List<CallLogEntry>> groups;
  final List<Color> codes = [const Color(0xff00821e), const Color(0xff7c0082),const Color(0xff210082),const Color(0xff668200),const Color(0xff820000)];
  SliverListT({super.key, required this.groups});

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


  @override
  Widget build(BuildContext context) {
    // void showSnackbar(String message) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(message),
    //   ));
    // }
    // return FutureBuilder(
    //   future: CallLog.get(),
    //   builder: (context, snapshot) {
    //
    //     // Check if number is null
    //
    //
    //
    //     if(snapshot.connectionState == ConnectionState.done) {
          return
            SliverList(
              delegate: SliverChildBuilderDelegate(
              childCount: groups.length,
              (context, index) {

            // Check if number is null


            if (index >= groups.length)
              return const SizedBox(height: 0,);
            print("Length is: ${groups[index].length}");
            if (groups[index].isEmpty)
              return const SizedBox(height: 0,);

            if (groups[index].isNotEmpty) {
              // _date = DateTime.fromMillisecondsSinceEpoch(
              //     groups[index][0].timestamp!);
              // _listdate = "${_date.day}-${_date.month}-${_date.year}";
            }
            var firstEntry = groups[index][0];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal:21.0),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 26.44,
                                // backgroundImage: AssetImage('assets/images/face1.jpeg'),
                                backgroundColor: codes[Random().nextInt(5)].withOpacity(0.4),
                                child: Text(
                                  firstEntry.name == null || firstEntry.name == "" ? "" : ((firstEntry.name).toString())[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.75),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      (firstEntry.name!.isEmpty ? (firstEntry.number): firstEntry.name).toString(),
                                      style: const TextStyle(
                                          fontSize: 16.59,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff676578)
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  (firstEntry.name!.isNotEmpty) ?
                                  Row(
                                    children: [
                                      Text(firstEntry.number.toString(),
                                        style: const TextStyle(
                                            fontSize: 12.44,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff9B98A4)
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      (groups[index].length > 1) ?
                                      Text(
                                        "(${groups[index].length})",
                                        style: const TextStyle(
                                            fontSize: 12.44,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff9B98A4)
                                        ),
                                      ) :const SizedBox(height: 0),
                                    ],
                                  ):const SizedBox(height: 0),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              SizedBox(
                                height: 14,
                                width: 14,
                                child: SvgPicture.asset(
                                  firstEntry.callType == CallType.outgoing
                                      ? 'assets/icons/outgoing.svg'
                                      :
                                  (firstEntry.callType == CallType.incoming ?
                                  'assets/icons/incoming.svg' :
                                  'assets/icons/missed.svg'),
                                  color:
                                  firstEntry.callType == CallType.missed
                                      ? const Color(0xffE85461)
                                      : const Color(0xff93CB80),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),

                              Text(
                                getTime(DateTime.fromMillisecondsSinceEpoch(firstEntry.timestamp!))!,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff9B98A4)
                                ),
                              ),

                            ],
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            );
          })
            // );}
          // }
          // else {
          //   return  SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),));
          // }


      // },
      // child: SliverList(
      //   delegate: SliverChildBuilderDelegate(
      //       childCount: groups.length,
      //
      //           (context, index) {
      //
      //         // Check if number is null
      //
      //
      //         if (index >= groups.length)
      //           return const SizedBox(height: 0,);
      //         print("Length is: ${groups[index].length}");
      //         if (groups[index].isEmpty)
      //           return const SizedBox(height: 0,);
      //
      //         if (groups[index].isNotEmpty) {
      //           // _date = DateTime.fromMillisecondsSinceEpoch(
      //           //     groups[index][0].timestamp!);
      //           // _listdate = "${_date.day}-${_date.month}-${_date.year}";
      //         }
      //         var firstEntry = groups[index][0];
      //         return Padding(
      //
      //           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal:21.0),
      //           child: Ink(
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.white,
      //             ),
      //             child: InkWell(
      //               onTap: () {
      //                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
      //               },
      //               child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         CircleAvatar(
      //                             radius: 26.44,
      //                             // backgroundImage: AssetImage('assets/images/face1.jpeg'),
      //                             backgroundColor: codes[Random().nextInt(5)].withOpacity(0.4),
      //                             child: Text(
      //                               firstEntry.name == null || firstEntry.name == "" ? "" : ((firstEntry.name).toString())[0].toUpperCase(),
      //                               style: const TextStyle(
      //                                 fontSize: 18,
      //                                 fontWeight: FontWeight.w600,
      //                                 color: Colors.white,
      //                               ),
      //                             )
      //                         ),
      //                         Padding(
      //                           padding: const EdgeInsets.only(left: 12.75),
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //
      //                               SizedBox(
      //                                 width: MediaQuery.of(context).size.width * 0.5,
      //                                 child: Text(
      //                                   (firstEntry.name ?? (firstEntry.number ?? "")).toString(),
      //                                   style: const TextStyle(
      //                                       fontSize: 16.59,
      //                                       fontWeight: FontWeight.w400,
      //                                       color: Color(0xff676578)
      //                                   ),
      //                                   softWrap: true,
      //                                   overflow: TextOverflow.ellipsis,
      //                                 ),
      //                               ),
      //                               (firstEntry.name != null) ?
      //                               Row(
      //                                 children: [
      //                                   Text(firstEntry.number.toString(),
      //                                     style: const TextStyle(
      //                                         fontSize: 12.44,
      //                                         fontWeight: FontWeight.w400,
      //                                         color: Color(0xff9B98A4)
      //                                     ),
      //                                   ),
      //                                   const SizedBox(width: 6),
      //                                   (groups[index].length > 1) ?
      //                                   Text(
      //                                     "(${groups[index].length})",
      //                                     style: const TextStyle(
      //                                         fontSize: 12.44,
      //                                         fontWeight: FontWeight.w400,
      //                                         color: Color(0xff9B98A4)
      //                                     ),
      //                                   ) :const SizedBox(height: 0),
      //                                 ],
      //                               ):const SizedBox(height: 0),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       width: 85,
      //                       child: Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         children: [
      //
      //                           SizedBox(
      //                             height: 14,
      //                             width: 14,
      //                             child: SvgPicture.asset(
      //                               firstEntry.callType == CallType.outgoing
      //                                   ? 'assets/icons/outgoing.svg'
      //                                   :
      //                               (firstEntry.callType == CallType.incoming ?
      //                               'assets/icons/incoming.svg' :
      //                               'assets/icons/missed.svg'),
      //                               color:
      //                               firstEntry.callType == CallType.missed
      //                                   ? const Color(0xffE85461)
      //                                   : const Color(0xff93CB80),
      //                               fit: BoxFit.scaleDown,
      //                             ),
      //                           ),
      //
      //                           Text(
      //                             getTime(DateTime.fromMillisecondsSinceEpoch(firstEntry.timestamp!))!,
      //                             style: const TextStyle(
      //                                 fontSize: 12,
      //                                 fontWeight: FontWeight.w400,
      //                                 color: Color(0xff9B98A4)
      //                             ),
      //                           ),
      //
      //                         ],
      //                       ),
      //                     ),
      //                   ]
      //               ),
      //             ),
      //           ),
      //         );
      //       }
      //
      //   ),
      //
      //
      // ),
    );
  }
}