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
setWebController(){
  webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          print(progress);
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('http://93.188.167.72/balance-admin/'));
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWebController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title:  Text(widget.title??""),
      ),
      body:true?Center(
        child: Text(
          'In Progress.......',
            style: TextStyle(color: AppColors.primaryColor,fontSize: 22)
        ),
      ): WebViewWidget(
        controller: webViewController)

    );
  }
}