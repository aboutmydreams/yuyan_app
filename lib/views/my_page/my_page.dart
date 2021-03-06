import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yuyan_app/state_manage/toppest.dart';
import 'package:yuyan_app/util/analytics.dart';
import 'package:yuyan_app/util/get_version.dart';
import 'package:yuyan_app/views/my_page/view/bottom_column.dart';
import 'package:yuyan_app/views/my_page/view/user_info.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
    // _controller.addListener(() {
    //   print(_controller.position.pixels);
    //   if (_controller.position.pixels == _controller.position.maxScrollExtent) {
    //     // getMoreData();
    //   }
    // });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    analytics.logEvent(name: 'my_page', parameters: {'name': '/MyPage'});
    List<Widget> widgetList = [
      userInfo(context),
      threeWidget(context),
      SizedBox(height: 300)
    ];
    getVersion();

    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          // 背景图形
          Positioned(
            top: 0,
            child: ClipPath(
              clipper: ArcClipper(),
              child: ScopedModelDescendant<TopStateModel>(
                builder: (context, child, model) {
                  print("model.primarySwatchColor=====");
                  print(theme.primaryColor);
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      gradient: LinearGradient(
                        colors: [
                          theme.primaryColor,
                          theme.primaryColor.withAlpha(60)
                        ],
                        begin: FractionalOffset(0, 0),
                        end: FractionalOffset(0, 1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(55, 0, 0, 0),
                          offset: Offset(1, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 56,
              child: ListView.builder(
                // controller: _controller,
                itemCount: widgetList.length,
                itemBuilder: (BuildContext context, int index) {
                  return widgetList[index];
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
