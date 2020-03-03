import 'package:flutter/material.dart';

void main() => runApp(GVContaApp());

class GVContaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GVConta',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
          appBar: AppBar(title: Text('Welcome to GVConta')),
          body: SafeArea(
            child: Center(child: Text('Welcome to GVConta, my friend')),
          )),
    );
  }
}
