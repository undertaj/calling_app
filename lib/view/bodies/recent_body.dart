import 'dart:math';

import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecentsBody extends StatefulWidget {
  final List<List<CallLogEntry>> groups;
  const RecentsBody({super.key, required this.groups});

  @override
  State<RecentsBody> createState() => _RecentsBodyState();
}

class _RecentsBodyState extends State<RecentsBody> {
  final ScrollController _scrollController = ScrollController();
  final List<Color> codes = [const Color(0xff00821e), const Color(0xff7c0082),const Color(0xff210082),const Color(0xff668200),const Color(0xff820000)];




  @override
  Widget build(BuildContext context) {

    DateTime _date;
    String _listdate = "";
    DateTime _currentDate = DateTime.now();
    String today = "${_currentDate.day}-${_currentDate.month}-${_currentDate.year}";
    DateTime yesterday = DateTime.now().subtract(const Duration(days:1));
    String yest = "${yesterday.day}-${yesterday.month}-${yesterday.year}";
    print(today+yest+_listdate);

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
    // {entry.formattedNumber}', ),
    // {entry.cachedMatchedNumber}', ),
    // {entry.number}', ),
    // {entry.name}',),
    // {entry.callType}', ),
    // {DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)}',),
    // {entry.duration}', ),
    // {entry.phoneAccountId}', ),
    // {entry.simDisplayName}', ),

    return ListView.builder(

            padding: const EdgeInsets.only(left:21.0, right: 21.0),
            itemCount: widget.groups.length,
            itemBuilder:
                (context, index) {
              List<List<CallLogEntry>> groups = widget.groups;

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

                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) =>DialerPage()));
                    },
                    child: Container(
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
                                          (firstEntry.name == null ? (firstEntry.number ?? "") : firstEntry.name).toString(),
                                          style: const TextStyle(
                                              fontSize: 16.59,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff676578)
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      (firstEntry.name != null) ?
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
                ),
              );
            }

        );
  }
}

