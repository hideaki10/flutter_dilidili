import 'package:flutter/material.dart';
import 'package:flutter_dilidili/model/video_model.dart';
import 'package:flutter_dilidili/navigator/hi_navigator.dart';

///
class HomePage extends StatefulWidget {
  ///
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic listener;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HiNavigator.getNaviatorInstance.addListener(listener = (current, pre) {
      print("current +++++++${current.page}");
      print("prepage +++++++++${pre.page}");
      if (widget == current.page || current.page is HomePage) {
        print("us ");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("beiyaohoutai");
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    HiNavigator.getNaviatorInstance.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            const Text('shouye'),
            MaterialButton(
              onPressed: () {
                HiNavigator.getNaviatorInstance.onJumpTo(RouteStatus.detail,
                    args: {'videoMo': VideoModel(1001)});
              },
              child: const Text('detial'),
            ),
          ],
        ),
      ),
    );
  }
}
