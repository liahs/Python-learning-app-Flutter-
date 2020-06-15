import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatelessWidget{
  final String url;
  Web({Key key,this.url}):super(key:key);

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child:WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    ));
  }
}
