
import 'package:flutter_study_app/utils/platform_utils.dart';
import 'package:sentry/sentry.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry/sentry.dart' as Sentry;


var _sentryClient = Sentry.SentryClient(
    dsn: 'http://d5c4bd2894c54412b7139e15cd356d0f@192.168.0.33:9000/5'
);

class ExceptionReporter {

  /// 初始化Sentry
  /// 填写 uid
  static void initSentryWithUid(String uid) {
    _sentryClient.userContext = Sentry.User(id: uid);
  }

  static Future<Null> reportError(dynamic error, dynamic stackTrace) async {
    Map<String, dynamic> deviceInfo = await PlatformUtils
        .getMapFromDeviceInfo();
    String appVersion = await PlatformUtils.getAppVersion();
    Map<String, dynamic> _errMap = {
      '\n 错误类型 \n': error.runtimeType.toString(),
      '\n 应用版本 \n': appVersion,
      '\n 设备信息 \n': deviceInfo,
      '\n 错误信息 \n': error.toString()
    };
    // Sentry上报
    //_sentryClient.captureException(exception: '$_errMap',stackTrace: stackTrace);
    final SentryResponse response = await _sentryClient.capture(
      event: Event(
        exception: '$_errMap',
        stackTrace: stackTrace,
      ),
    );
    // 上报结果处理
    if (response.isSuccessful) {
      print('Success! Event ID: ${response.eventId}');
    } else {
      print('Failed to report to Sentry.io: ${response.error}');
    }
  }
}