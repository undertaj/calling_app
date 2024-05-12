import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliverListT extends StatelessWidget {
  final List<List<CallLogEntry>> groups;
  final List<Color> codes = [const Color(0xff00821e), const Color(0xff7c0082),const Color(0xff210082),const Color(0xff668200),const Color(0xff820000)];
  SliverListT({super.key, required this.groups});
  bool f = true;
  String prevDate = "";
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
    DateTime _date;
    String list_date = "";
    // if(f) {
    //   f = false;
    //   int i = 0;
    //   while(i < groups[0].length ) {
    //     if (kDebugMode) {
    //       print(groups[0][i].name);
    //       print(getTime(DateTime.fromMicrosecondsSinceEpoch(groups[0][i].timestamp!)));
    //     }
    //     i++;
    //   }
    // }
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
                // if (index >= groups.length)
                //   return const SizedBox(height: 0,);
                // print("  Length is: ${groups[index].length}");
                // if(groups[index].length > 0) {
                //   print("NAME is ${groups[index][0].name ?? ""}");
                // }

                if (groups[index].isEmpty || groups[index].length == 0) {
                  return const SizedBox(height: 0,);
                }

                if (groups[index].isNotEmpty) {
                  _date = DateTime.fromMillisecondsSinceEpoch(
                      groups[index][0].timestamp!);
                  list_date = "${_date.day}/${_date.month}/${_date.year}";
                }
                Widget x = const SizedBox(height:  0,);
                bool check = false;
                if(prevDate != list_date) {
                  check = true;
                  x = Center(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffE7E6EE),
                        ),
                        child: Text(
                          list_date,
                          // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.44,
                          ),
                        )),
                  );
                  prevDate = list_date;
                }

                var firstEntry = groups[index][0];
                return
                  (check) ? x :
                  Ink(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal:21.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 26.44,
                                      // backgroundImage: AssetImage('assets/images/face1.jpeg'),
                                      backgroundColor: codes[Random().nextInt(5)].withOpacity(0.4),
                                      child:
                                      (firstEntry.name == null || firstEntry.name == "") ?
                                      SvgPicture.asset('assets/images/person_s.svg', color : Colors.white, )
                                      // Image.asset('assets/images/user_figure.jpg', height: 10,width: 10,)
                                          :
                                      Text(
                                        // 'C',
                                        ((firstEntry.name).toString())[0].toUpperCase(),
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
                                            (firstEntry.name == null || firstEntry.name == "" ? (firstEntry.number): firstEntry.name).toString(),
                                            style: const TextStyle(
                                                fontSize: 16.59,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff676578)
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        (firstEntry.name == null || firstEntry.name == "") ? const SizedBox(height: 0) :
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
                                        ),
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

// class SliverListT1 extends StatelessWidget {
//   final List<Map<String, List<CallLogEntry>>> groups1;
//   final List<Color> codes = [const Color(0xff00821e), const Color(0xff7c0082),const Color(0xff210082),const Color(0xff668200),const Color(0xff820000)];
//   SliverListT1({super.key, required this.groups1});
//   bool f = true;
//   String prevDate = "";
//   String? getTime(DateTime time) {
//     int h = time.hour;
//     int m = time.minute;
//     if(h >= 12) {
//       if(h != 12) {
//         h-= 12;
//       }
//       return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m PM";
//     }
//     else {
//       if(h == 0) {
//         h+=12;
//       }
//       return "${h.toString().length == 1 ? '0': ''}$h:${m.toString().length == 1 ? '0': ''}$m AM";
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime _date;
//     String list_date = "";
//
//     // void showSnackbar(String message) {
//     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     //     content: Text(message),
//     //   ));
//     // }
//     // return FutureBuilder(
//     //   future: CallLog.get(),
//     //   builder: (context, snapshot) {
//     //
//     //     // Check if number is null
//     //
//     //
//     //
//     //     if(snapshot.connectionState == ConnectionState.done) {
//     return
//       SliverList(
//           delegate: SliverChildBuilderDelegate(
//               childCount: groups1.length,
//                   (context, index) {
//
//
//                 // Check if number is null
//                 // if (index >= groups.length)
//                 //   return const SizedBox(height: 0,);
//                 // print("  Length is: ${groups[index].length}");
//                 // if(groups[index].length > 0) {
//                 //   print("NAME is ${groups[index][0].name ?? ""}");
//                 // }
//
//                 if (groups1[index].isEmpty || groups1[index].length == 0) {
//                   return const SizedBox(height: 0,);
//                 }
//                 //
//                 // if (groups1[index].isNotEmpty) {
//                 //   _date = DateTime.fromMillisecondsSinceEpoch(
//                 //       groups1[index].values..timestamp!);
//                 //   list_date = "${_date.day}/${_date.month}/${_date.year}";
//                 // }
//                 Widget x = const SizedBox(height:  0,);
//                 bool check = false;
//                 if(prevDate != list_date) {
//                   check = true;
//                   x = Center(
//                     child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: const Color(0xffE7E6EE),
//                         ),
//                         child: Text(
//                           list_date,
//                           // today == _listdate ? "Today" : (_listdate == yest ? "Yesterday" : _listdate),
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 12.44,
//                           ),
//                         )),
//                   );
//                   prevDate = list_date;
//                 }
//
//                 var firstMap = groups1[index];
//                 return
//
//                   (check) ? x :
//                   Ink(
//                     decoration: BoxDecoration(
//                       // borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal:21.0),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   CircleAvatar(
//                                       radius: 26.44,
//                                       // backgroundImage: AssetImage('assets/images/face1.jpeg'),
//                                       backgroundColor: codes[Random().nextInt(5)].withOpacity(0.4),
//                                       child: Text(
//                                         // 'C',
//                                         firstEntry.name == null || firstEntry.name == "" ? "" : ((firstEntry.name).toString())[0].toUpperCase(),
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 12.75),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//
//                                         SizedBox(
//                                           width: MediaQuery.of(context).size.width * 0.5,
//                                           child: Text(
//                                             (firstEntry.name == null || firstEntry.name == "" ? (firstEntry.number): firstEntry.name).toString(),
//                                             style: const TextStyle(
//                                                 fontSize: 16.59,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Color(0xff676578)
//                                             ),
//                                             softWrap: true,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                         (firstEntry.name == null || firstEntry.name == "") ? const SizedBox(height: 0) :
//                                         Row(
//                                           children: [
//                                             Text(firstEntry.number.toString(),
//                                               style: const TextStyle(
//                                                   fontSize: 12.44,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color(0xff9B98A4)
//                                               ),
//                                             ),
//                                             const SizedBox(width: 6),
//                                             (groups[index].length > 1) ?
//                                             Text(
//                                               "(${groups[index].length})",
//                                               style: const TextStyle(
//                                                   fontSize: 12.44,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Color(0xff9B98A4)
//                                               ),
//                                             ) :const SizedBox(height: 0),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 85,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   children: [
//
//                                     SizedBox(
//                                       height: 14,
//                                       width: 14,
//                                       child: SvgPicture.asset(
//                                         firstEntry.callType == CallType.outgoing
//                                             ? 'assets/icons/outgoing.svg'
//                                             :
//                                         (firstEntry.callType == CallType.incoming ?
//                                         'assets/icons/incoming.svg' :
//                                         'assets/icons/missed.svg'),
//                                         color:
//                                         firstEntry.callType == CallType.missed
//                                             ? const Color(0xffE85461)
//                                             : const Color(0xff93CB80),
//                                         fit: BoxFit.scaleDown,
//                                       ),
//                                     ),
//
//                                     Text(
//                                       getTime(DateTime.fromMillisecondsSinceEpoch(firstEntry.timestamp!))!,
//                                       style: const TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w400,
//                                           color: Color(0xff9B98A4)
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                             ]
//                         ),
//                       ),
//                     ),
//                   );
//               })
//         // );}
//         // }
//         // else {
//         //   return  SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),));
//         // }
//
//
//         // },
//         // child: SliverList(
//         //   delegate: SliverChildBuilderDelegate(
//         //       childCount: groups.length,
//         //
//         //           (context, index) {
//         //
//         //         // Check if number is null
//         //
//         //
//         //         if (index >= groups.length)
//         //           return const SizedBox(height: 0,);
//         //         print("Length is: ${groups[index].length}");
//         //         if (groups[index].isEmpty)
//         //           return const SizedBox(height: 0,);
//         //
//         //         if (groups[index].isNotEmpty) {
//         //           // _date = DateTime.fromMillisecondsSinceEpoch(
//         //           //     groups[index][0].timestamp!);
//         //           // _listdate = "${_date.day}-${_date.month}-${_date.year}";
//         //         }
//         //         var firstEntry = groups[index][0];
//         //         return Padding(
//         //
//         //           padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal:21.0),
//         //           child: Ink(
//         //             decoration: BoxDecoration(
//         //               borderRadius: BorderRadius.circular(10),
//         //               color: Colors.white,
//         //             ),
//         //             child: InkWell(
//         //               onTap: () {
//         //                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
//         //               },
//         //               child: Row(
//         //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //                   children: [
//         //                     Row(
//         //                       children: [
//         //                         CircleAvatar(
//         //                             radius: 26.44,
//         //                             // backgroundImage: AssetImage('assets/images/face1.jpeg'),
//         //                             backgroundColor: codes[Random().nextInt(5)].withOpacity(0.4),
//         //                             child: Text(
//         //                               firstEntry.name == null || firstEntry.name == "" ? "" : ((firstEntry.name).toString())[0].toUpperCase(),
//         //                               style: const TextStyle(
//         //                                 fontSize: 18,
//         //                                 fontWeight: FontWeight.w600,
//         //                                 color: Colors.white,
//         //                               ),
//         //                             )
//         //                         ),
//         //                         Padding(
//         //                           padding: const EdgeInsets.only(left: 12.75),
//         //                           child: Column(
//         //                             crossAxisAlignment: CrossAxisAlignment.start,
//         //                             children: [
//         //
//         //                               SizedBox(
//         //                                 width: MediaQuery.of(context).size.width * 0.5,
//         //                                 child: Text(
//         //                                   (firstEntry.name ?? (firstEntry.number ?? "")).toString(),
//         //                                   style: const TextStyle(
//         //                                       fontSize: 16.59,
//         //                                       fontWeight: FontWeight.w400,
//         //                                       color: Color(0xff676578)
//         //                                   ),
//         //                                   softWrap: true,
//         //                                   overflow: TextOverflow.ellipsis,
//         //                                 ),
//         //                               ),
//         //                               (firstEntry.name != null) ?
//         //                               Row(
//         //                                 children: [
//         //                                   Text(firstEntry.number.toString(),
//         //                                     style: const TextStyle(
//         //                                         fontSize: 12.44,
//         //                                         fontWeight: FontWeight.w400,
//         //                                         color: Color(0xff9B98A4)
//         //                                     ),
//         //                                   ),
//         //                                   const SizedBox(width: 6),
//         //                                   (groups[index].length > 1) ?
//         //                                   Text(
//         //                                     "(${groups[index].length})",
//         //                                     style: const TextStyle(
//         //                                         fontSize: 12.44,
//         //                                         fontWeight: FontWeight.w400,
//         //                                         color: Color(0xff9B98A4)
//         //                                     ),
//         //                                   ) :const SizedBox(height: 0),
//         //                                 ],
//         //                               ):const SizedBox(height: 0),
//         //                             ],
//         //                           ),
//         //                         ),
//         //                       ],
//         //                     ),
//         //                     SizedBox(
//         //                       width: 85,
//         //                       child: Row(
//         //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //                         children: [
//         //
//         //                           SizedBox(
//         //                             height: 14,
//         //                             width: 14,
//         //                             child: SvgPicture.asset(
//         //                               firstEntry.callType == CallType.outgoing
//         //                                   ? 'assets/icons/outgoing.svg'
//         //                                   :
//         //                               (firstEntry.callType == CallType.incoming ?
//         //                               'assets/icons/incoming.svg' :
//         //                               'assets/icons/missed.svg'),
//         //                               color:
//         //                               firstEntry.callType == CallType.missed
//         //                                   ? const Color(0xffE85461)
//         //                                   : const Color(0xff93CB80),
//         //                               fit: BoxFit.scaleDown,
//         //                             ),
//         //                           ),
//         //
//         //                           Text(
//         //                             getTime(DateTime.fromMillisecondsSinceEpoch(firstEntry.timestamp!))!,
//         //                             style: const TextStyle(
//         //                                 fontSize: 12,
//         //                                 fontWeight: FontWeight.w400,
//         //                                 color: Color(0xff9B98A4)
//         //                             ),
//         //                           ),
//         //
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ]
//         //               ),
//         //             ),
//         //           ),
//         //         );
//         //       }
//         //
//         //   ),
//         //
//         //
//         // ),
//       );
//   }
// }