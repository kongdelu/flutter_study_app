

import 'package:flutter/material.dart';
import 'package:flutter_study_app/model/author.dart';
import 'package:flutter_study_app/utils/exception_reporter.dart';

class PageRoute2 extends StatelessWidget {

  final List<String> items = ["a","b","c"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("PageRoute2",style: TextStyle(color: Colors.white),),
        ),
        body: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("按钮1"),
                onPressed: (){
                  // try {
                   //throw Exception("This is a test exception");
                    print(items[4]);
                  // } catch (error,stack) {
                  //   ExceptionReporter.reportError(error, stack);
                  // }
                }),
              FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("按钮2"),
                  onPressed: (){
                    var obj = {"name":"whisky", "title":'阿发生的发生阿斯蒂芬暗示法按时', "id":2020};
                    var c = Author.fromJson(obj);
                    print("作者的名字是："+c.name);
                    print("作者的名字是："+c.title);
                    print('${c.id}');
                    print('${c.id.runtimeType}');
                    print(c);
                  })],
          )
        )
    );
  }
}