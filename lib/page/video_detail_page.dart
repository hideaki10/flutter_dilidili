import 'package:flutter/material.dart';
import 'package:flutter_dilidili/model/video_model.dart';

///
class VideoDetailPage extends StatefulWidget {
  ///
  const VideoDetailPage({Key? key, this.videoModel}) : super(key: key);

  ///
  final VideoModel? videoModel;

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text('detail vid:${widget.videoModel!.vid}'),
      ),
    );
  }
}
