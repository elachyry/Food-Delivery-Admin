import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.4,
      child: Column(
        children: [
          Image.asset(
            'assets/delevry-outline.gif',
            width: 200,
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          Image.asset(
            'assets/logo.png',
            width: 200,
          ),
        ],
      ),
    );
  }
}
