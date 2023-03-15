import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class LogPage extends StatefulWidget {
  const LogPage({Key? key}) : super(key: key);

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(minWidth: 360),
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: AlignmentDirectional.topStart,
                    height: 300,
                    width: size.width,
                    child: LimitedBox(
                      maxHeight: 200,
                      child: Center(
                        child: Container(
                            height: 92,
                            width: 82,
                            child: Image.asset('assets/img.png')),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: size.width,
                            child: LimitedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFAFAFA),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Color(0xFFD2D2D2),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 16),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                                'assets/email_icon.png'),
                                            labelText: 'Email',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                          color: Color(0xFFD2D2D2),
                                          thickness: 1),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                                'assets/pass_icon.png'),
                                            labelText: 'Password',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        child: TextButton(
                            onPressed: () {},
                            child: Text('Forgot your password?', style: TextStyle(fontSize: 15, color:Color(0xFF8C8C8C)),)),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 92),
                    child: Container(
                      alignment: AlignmentDirectional.bottomCenter,
                      height: 150,
                      width: 300,
                      child: LimitedBox(
                        maxHeight: 300,
                        child: Center(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/home');
                                  },
                                  color: Color(0xFF33C283),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minWidth: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        40, 20, 40, 20),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: Text.rich(TextSpan(
                                      text: 'Don\'t have an account?  ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                      children: [
                                        TextSpan(
                                          text: 'Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF33C283)),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.of(context)
                                                .pushNamed('/sing'),
                                        ),
                                      ])),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
