import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NewsView extends StatefulWidget {

  String url;
  NewsView(this.url);
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
    String finalUrl;
  final Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  void initState() {
    if(widget.url.toString().contains("http://"))
    {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    }
    else{
      finalUrl = widget.url;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        // leading: IconButton(
        //   //onPressed: Navigator.of(context).pop(),
        //   icon: Icon(Icons.arrow_back,color: Colors.black,),
        // ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.bookmark_add)
            ),
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.share)
            ),
        ],
      ),
      body: Container(
        child: WebView(
          initialUrl: finalUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}
