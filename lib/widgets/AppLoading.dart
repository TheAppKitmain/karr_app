import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';


class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Platform.isAndroid
          ?  Center(
              child: Column(
                children: [
                  Text('Deleting'),
                  CircularProgressIndicator(
                  color:Theme.of(context).brightness == Brightness.dark?Colors.white: AppColors.primaryColor,
                              ),
                ],
              ))
          :  Center(
              child: CupertinoActivityIndicator(
                radius: 20,
                color:Theme.of(context).brightness == Brightness.dark?Colors.white: AppColors.primaryColor,
              ),
            ),
    );
  }
}

