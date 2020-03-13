import 'package:flutter/material.dart';
import 'package:gvconta/pages/account_list_page.dart';
import 'package:gvconta/pages/account_page.dart';
import 'package:gvconta/pages/category_list_page.dart';
import 'package:gvconta/pages/diary_page.dart';
import 'package:gvconta/pages/edit_account_page.dart';
import 'package:gvconta/pages/edit_profile_page.dart';
import 'package:gvconta/pages/event_list_page.dart';
import 'package:gvconta/pages/root_page.dart';
import 'package:gvconta/pages/shared_account_list_page.dart';
import 'package:gvconta/system/auth.dart';
import 'package:gvconta/system/auth_provider.dart';
import 'package:gvconta/system/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(GVContaApp());

class GVContaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;

    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        localizationsDelegates: [
          i18n,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: i18n.supportedLocales,
        localeResolutionCallback:
            i18n.resolution(fallback: new Locale("en", "US")),
        title: 'GV Conta',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: '/', //No es necesario
        routes: {
          '/': (_) => RootPage(),
          '/account_list': (_) => AccountListPage(),
          '/shared_account_list': (_) => SharedAccountListPage(),
          '/category_list': (_) => CategoryListPage(),
          '/account': (_) => AccountPage(),
          '/diary': (_) => DiaryPage(),
          '/event_list': (_) => EventListPage(),
          '/edit_account': (_) => EditAccountPage(),
          '/edit_profile': (_) => EditProfilePage(),
        },
      ),
    );
  }
}
