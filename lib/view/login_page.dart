import 'package:caller_app/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _val = 1;

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffffffff),
                    Color(0xffd3d3d3),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal:  MediaQuery.of(context).size.width * 0.1,
            //       vertical: MediaQuery.of(context).size.height * 0.20),
            Positioned(
                top:  MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.1,

              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Welcome to Lead Hornet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 56,),

                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        const Text('Mobile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: Colors.black,
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffD9D9D9),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.white.withOpacity(0),
                                width: 0
                              ),
                              borderRadius: new BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.white.withOpacity(0),
                                    width: 0
                                ),
                              borderRadius: new BorderRadius.circular(5),
                            ),
                          ),

                        ),
                      ],
                    ),
                    SizedBox(height: 18,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        const Text('Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: Colors.black,
                          ),
                        ),
                        TextField(
                          obscureText: _val == 1 ? true : false,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _val == 1 ? Icons.visibility_off :Icons.visibility),
                                onPressed: (){

                                  setState(() {
                                    _val = _val == 1 ? 2 : 1;
                                  })  ;
                                  },
                            ),
                            filled: true,

                            fillColor: Color(0xffD9D9D9),
                            enabledBorder: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.white.withOpacity(0),
                                  width: 0
                              ),
                              borderRadius: new BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.white.withOpacity(0),
                                  width: 0
                              ),
                              borderRadius: new BorderRadius.circular(5),
                            ),
                          ),

                        ),

                      ],
                    ),
                    SizedBox(height: 29,),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Color(0xff000000),
                            value: check, onChanged: (_){
                          setState(() {
                            check = !check;
                          });
                        }),
                        Text('I agree to provide my data for Internal Purpose',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Inter',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 44,),
                    InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeEpigle()));},
                      child: Container(
                        height: 45,
                        width: 129,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff9B98A4),
                              Color(0xff575757),
                            ],
                          ),

                        ),
                        padding: EdgeInsets.symmetric(horizontal: 43, vertical: 10),
                        child: Text('Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            color: Colors.white,
                          ),
                        ),

                      ),
                    ),
                    // Stack(
                    //   children: [

                    //   ]
                    // )

                  ]
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.25,
              top: MediaQuery.of(context).size.height * 0.96,
              child: Text('Powered by Cryptographic Solutions',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Color(0xff3A3A3A),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
