
import 'package:flutter/material.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.brown
];

class Global {

  //可选主题列表
  static List<MaterialColor> get themes {
    return _themes;
  }

  // 是否为release版本
  static bool get isRelease {
    return bool.fromEnvironment("dart.vm.product");
  }

  //初始化全局信息，APP启动时执行
  static Future init() async {

  }

  // 持久化Profile信息
  static saveProfile() {

  }
}