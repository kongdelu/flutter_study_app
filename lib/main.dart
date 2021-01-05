
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_study_app/config/app_config.dart';
import 'package:flutter_study_app/ui/widget/tabs.dart';
import 'package:flutter_study_app/utils/exception_reporter.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';

import 'generated/l10n.dart';

///创建错误widget body
Widget getErrorWidget(dynamic details) {
  return Container(
    color: Colors.white,
    child: Center(
      child: Text("出错啦！！！",style: TextStyle(color: Colors.black,fontSize: 26)),
    )
  );
}

void main() {
  ///自定义红屏异常
  ErrorWidget.builder = (FlutterErrorDetails details) {
    ExceptionReporter.reportError(details, null);
    return MaterialApp(
      title: 'Error Widget',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget渲染异常！！！'),
        ),
        body: getErrorWidget(details.toString()),
      ),
    );
  };

  FlutterError.onError = (FlutterErrorDetails details) async {
    if (AppConfig.isProduction) {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
    else {
      FlutterError.dumpErrorToConsole(details);
    }
  };

  ///初始化Sentry
  ExceptionReporter.initSentryWithUid('1001');

  runZoned(() async {
    runApp(MyApp());
  }, onError: (dynamic error,StackTrace stackTrace) async {
    showToast(">>>"+error.toString());
    //Sentry上报
    ExceptionReporter.reportError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(child: new MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        //GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('zh',''),...S.delegate.supportedLocales],
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.lightBlue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Tabs(),
    ));
  }
}