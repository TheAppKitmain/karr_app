import 'package:flutter/material.dart';
import 'package:kaar/utils/Constants.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class WebViewClass extends StatefulWidget {
  final String? title;
  final String? url;
  WebViewClass({this.title,this.url, super.key});
  @override
  _WebViewClassState createState() => _WebViewClassState();
}

class _WebViewClassState extends State<WebViewClass> {
  WebViewController webViewController = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title:  Text(widget.title??""),
      ),
      body: WebViewWidget(
        controller: webViewController..loadRequest(Uri.parse(widget.url??"www.google.com"))

      )
    );
  }
}