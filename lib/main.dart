import 'package:flutter/material.dart';
import 'package:gvconta/pages/root_page.dart';
import 'package:gvconta/system/auth.dart';
import 'package:gvconta/system/auth_provider.dart';

void main() => runApp(GVContaApp());

class GVContaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'GVConta',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: RootPage(),
      ),
    );
  }
}
