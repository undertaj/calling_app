import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/cross.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),



      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.77,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Menu',
              style: TextStyle(

                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xff2D2D41),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 26.71),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/home_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Home',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/notif_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Notifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/block_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Block User',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/faq_profile_icon.svg'),
                      const SizedBox(width: 28,),
                      const Text('FAQ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/feedback_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Send Feedback',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/invite_profile.svg'),
                      const SizedBox(width: 28,),
                      const Text('Invite Friends',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff484554),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 107,
              left: MediaQuery.of(context).size.width * 0.07,
              child: Container(
                width: 336,
                height: 336,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffE7E6EE),

                ),
                child: null,
              ),
            ),
            Positioned(
              bottom: 0,
              left: MediaQuery.of(context).size.width/3,
              right: MediaQuery.of(context).size.width/3,
              child: SvgPicture.asset('assets/images/nav_bar_pointer.svg'),
            ),
            Positioned(
                bottom: 38.65,
                left: MediaQuery.of(context).size.width * 0.34,
                right: MediaQuery.of(context).size.width * 0.34,
                child: const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/images/profile_face.jpg'),
                )
            ),
          ],
        ),
      ),

    );
  }
}