import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialerPage extends StatelessWidget {
  const DialerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30.79),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Dialing',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff9B98A4)
                  ),
                ),
                const SizedBox(height: 29.5,),

                Container(
                  height: 222,
                  width: 222,
                  child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 111.60,
                          backgroundColor: const Color(0xff5755D9).withOpacity(0.1),
                        ),
                        Positioned(
                          top: 19.61,
                          left: 19.61,
                          child: CircleAvatar(
                            radius: 91.99,
                            backgroundColor: const Color(0xff5755D9).withOpacity(0.3),
                          ),
                        ),
                        Positioned(
                          top: 35.97,
                          left: 35.85,
                          child: CircleAvatar(
                            radius: 75.76,

                            backgroundColor: const Color(0xff5755D9).withOpacity(0.7),
                          ),
                        ),




                        const Positioned(
                          top: 54.33,
                          left: 54.33,
                          child: CircleAvatar(
                            radius: 57.2,
                            backgroundImage: AssetImage('assets/images/face1.jpeg'),
                          ),
                        ),
                      ]
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Anitha Office',
                      style: TextStyle(
                          fontSize: 24.88,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff484554)
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_outlined,
                          color: Color(0xff9B98A4),
                          size: 16,
                        ),
                        Text('Bangalore, India',
                          style: TextStyle(
                            color: Color(0xff9B98A4),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.02,
                          ),
                        ),
                      ],
                    ),
                    Text('+91 9428573945',
                      style: TextStyle(
                          color: Color(0xff484554),
                          fontSize: 24.88,
                          fontWeight: FontWeight.w400
                      ),

                    )
                  ],
                ),
                const SizedBox(height: 36.33,),
                const Divider(
                  height: 0.93,
                  color: Color(0xff9B98A4),
                ),
                const SizedBox(height: 39.89,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset('assets/icons/mute_icon.svg'),
                        const SizedBox(height: 6.45,),
                        const Text('Mute',
                          style: TextStyle(
                            color: Color(0xff9B98A4),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.03,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset('assets/icons/bluetooth_icon.svg'),
                        const SizedBox(height: 6.45,),
                        const Text('Bluetooth',
                          style: TextStyle(
                            color: Color(0xff9B98A4),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.03,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SvgPicture.asset('assets/icons/hold_icon.svg'),
                        const SizedBox(height: 6.45,),
                        const Text('Hold',
                          style: TextStyle(
                            color: Color(0xff9B98A4),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.03,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 43,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/keypad.svg'),
                    ),
                    IconButton(
                      onPressed: () {},
                      // color: Color(0xff5755D9).withOpacity(0.15),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xff5755D9).withOpacity(0.15)),
                        fixedSize: MaterialStateProperty.all(const Size(71.84, 71.84)),

                      ),


                      icon: SvgPicture.asset('assets/icons/call_end.svg'),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/volume.svg'),
                    ),
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }
}