
import 'package:dio/dio.dart';
import 'dart:convert' as convert;

import 'package:flutter_study_app/net/result_code.dart';

class ResponseInterceptors extends InterceptorsWrapper{

  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
    if (response.statusCode == 200) {
      Map<String,dynamic> resultMap = convert.jsonDecode(response.data);
      if (resultMap["code"] == StatusCode.SUCCESS) {
        response.data = resultMap["text"];
      }
      else {
        print(resultMap["code"]);
      }
    }

    return super.onResponse(response);
  }
}