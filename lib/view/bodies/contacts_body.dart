import 'package:flutter/material.dart';

class ContactsBody extends StatelessWidget {
  final List<String> character = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
  ContactsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:21.0, top:10),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemCount: 7,

              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 19.44),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26.44,
                        backgroundImage: AssetImage('assets/images/face1.jpeg'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.75),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text('Akash',
                              style: TextStyle(
                                  fontSize: 16.59,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff676578)
                              ),
                            ),
                            Text('+972 76 264 861 6',
                              style: TextStyle(
                                  fontSize: 12.44,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B98A4)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: 26,
              itemBuilder: (context, index) {
                return Text(character[index],
                  style: const TextStyle(
                    fontSize: 11.98,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9B98A4),

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}