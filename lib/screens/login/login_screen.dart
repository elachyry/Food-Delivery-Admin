import 'package:flutter/material.dart';

import '../../config/responsive.dart';
import '../../config/size_config.dart';
import '../../widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  static const String appRoute = '/login';
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: !Responsive.isDesktop(context)
            ? SizedBox(
                child: Column(
                  children: <Widget>[
                    const LoginHeader(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 30,
                        left: 30,
                        bottom: 10,
                      ),
                      child: LoginForm(),
                    ),
                    const LoginFooter(),
                  ],
                ),
              )
            : Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth * 0.5,
                  child: Column(
                    children: <Widget>[
                      const LoginHeader(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 30,
                          left: 30,
                          bottom: 10,
                        ),
                        child: LoginForm(),
                      ),
                      // LoginFooter(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
