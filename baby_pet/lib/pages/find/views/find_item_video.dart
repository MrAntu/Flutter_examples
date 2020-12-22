import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../exports.dart';

class FindItemVedio extends StatefulWidget {
  final String videoURL;

  const FindItemVedio({Key key, this.videoURL}) : super(key: key);

  @override
  _FindItemVedioState createState() => _FindItemVedioState();
}

class _FindItemVedioState extends State<FindItemVedio> {
  VideoPlayerController _videoController;

  void _videoChanged() {
    if (widget.videoURL == null || widget.videoURL.length <= 0) {
      Navigator.of(context).pop();
      return;
    }
    if (_videoController != null) {
      _videoController.dispose();
    }
    _videoController = VideoPlayerController.network(widget.videoURL)
      ..initialize().then((value) {
        _videoController.pause();
        setState(() {});
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoURL)
      ..initialize().then((value) {
        _videoController.pause();
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(FindItemVedio oldWidget) {
    if (oldWidget.videoURL != widget.videoURL) {
      _videoChanged();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _videoController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth / 3 * 2,
      height: (ScreenUtil().screenWidth / 3 * 2) / 16 * 9,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(4)),
      child: Stack(
        children: _renderVideoItem(),
      ),
    );
  }

  List<Widget> _renderVideoItem() {
    List<Widget> list = [];
    final isInitial = _videoController.value.initialized;
    if (isInitial) {
      Widget playerItem = Center(
        child: AspectRatio(
          aspectRatio: _videoController.value.aspectRatio,
          child: VideoPlayer(_videoController),
        ),
      );
      list.add(playerItem);

      Widget pauseItem = Positioned(
          child: Center(
        child: Image.asset(
          Utils.getImgPath('video_play'),
          width: 55,
          height: 55,
        ),
      ));
      list.add(pauseItem);
    } else {
      Widget loading = Center(
        child: CircularProgressIndicator(),
      );
      list.add(loading);
    }

    return list;
  }
}
