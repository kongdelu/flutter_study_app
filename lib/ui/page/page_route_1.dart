
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_study_app/generated/l10n.dart';
import 'package:flutter_study_app/net/http_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageRoute1 extends StatefulWidget {
  final String text;

  const PageRoute1({Key key, this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageRoute1State();
  }
}

class _PageRoute1State extends State<PageRoute1> {

  List <String> _items = ['湖人','勇士','雄鹿','快船','凯尔特人','马刺'];
  //初始化滚动监听，加载更多
  ScrollController _controller = new ScrollController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
    setState(() {
      flag = true;
    });
  }
  void _onLoading() async {
    await Future.delayed((Duration(milliseconds: 2000)));
    //_items.add((_items.length+1).toString());
    _refreshController.loadNoData();
    if(mounted) {
      setState(() {

      });
    }

    //_refreshController.loadComplete();
  }

  final GlobalKey globalKey = GlobalKey();

  bool flag = false;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    Widget divider = Divider(color: Colors.grey,height: 0.5,);

    _controller.addListener(() {
      //获取列表偏移量
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
    });
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text(S.of(context).item,style: TextStyle(color: Colors.white),),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: flag,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body;
            if(mode == LoadStatus.idle){
              body = Text("pull up load");
            }
            else if(mode == LoadStatus.loading){
              body = CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed! Click retry");
            }
            else if(mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            }
            else {
              body = Text("No more data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: _items.length,
            cacheExtent: 80,
            controller: _controller,
            separatorBuilder: (BuildContext context, int index) {
              return divider;
            },
            itemBuilder: (BuildContext context,int index){
              if(_items.length == index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: Colors.red,
                );//_buildIsLoading();
              }
              // return ListTile(title: Text(_titles[index]),onTap: (){
              //   showToast("点击了第 $index 行");
              // });
              return GestureDetector(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    color: Colors.orange,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textDirection: TextDirection.ltr,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        _getListCell(Icons.access_alarm, _items[index]),
                        SpinKitWave(color: Colors.white, type: SpinKitWaveType.start),
                        //Icon(Icons.access_time)
                      ],
                    )
                ),
                onTap: (){
                  onItemClick(index);
                },
              );
            }),
      )
    );
  }

  void onItemClick(int index) async{
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("点击了第 $index 行")));
    // var result = await ApiManager.request('',method: ApiManager.GET,
    //     data: {'id':1});
    // print('返回数据: $result');
  }

  ///返回一个居中带图标和文本的Item
  _getListCell(IconData icon, String text) {
    ///充满 Row 横向的布局
    return new Expanded(
      flex: 3,
      ///居中显示
      child: new Center(
        ///横向布局
        child: new Row(
          ///主轴居中,即是横向居中
          mainAxisAlignment: MainAxisAlignment.start,
          ///大小按照最大充满
          mainAxisSize : MainAxisSize.max,
          ///竖向也居中
          crossAxisAlignment : CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: new EdgeInsets.only(left:30.0)),
            ///一个图标，大小16.0，灰色
            new Icon(
              icon,
              size: 39.0,
              color: Colors.grey,
            ),
            ///间隔
            new Padding(padding: new EdgeInsets.only(left:18.0)),
            ///显示文本
            new Text(
              text,
              //设置字体样式：颜色灰色，字体大小14.0
              style: new TextStyle(color: Colors.grey, fontSize: 22.0),
              //超过的省略为...显示
              overflow: TextOverflow.ellipsis,
              //最长一行
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //移除监听，防止内存泄露
    _controller.dispose();
    super.dispose();
  }
}