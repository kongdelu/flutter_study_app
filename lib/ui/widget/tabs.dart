
import 'package:flutter/material.dart';
import 'package:flutter_study_app/generated/l10n.dart';
import '../page/page_route_1.dart' ;
import '../page/page_route_2.dart';
import '../page/page_route_3.dart';

class Tabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  List listTabs = [PageRoute1(),PageRoute2(),PageRoute3()];
  @override
  Widget build(BuildContext context) {
    Widget divider = Divider(color: Colors.grey);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("App Name"),
      //   leading: Builder(builder: (context){
      //     return IconButton(icon: Icon(Icons.dashboard,color: Colors.white,), onPressed: (){
      //       Scaffold.of(context).openDrawer();
      //     });
      //   },),
      //   actions: <Widget>[
      //     IconButton(icon: Icon(Icons.share), onPressed: (){}),
      //   ],
      // ),
      // drawer: new Drawer(),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: S.of(context).home),
            BottomNavigationBarItem(icon: Icon(Icons.business),label: S.of(context).business),
            BottomNavigationBarItem(icon: Icon(Icons.school),label: S.of(context).school)
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
        body: listTabs[_selectedIndex]

    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

