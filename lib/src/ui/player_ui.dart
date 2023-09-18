import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PlayerUI extends StatefulWidget {
  final String url;
  const PlayerUI({super.key, required this.url});

  @override
  State<PlayerUI> createState() => _PlayerUIState();
}

class _PlayerUIState extends State<PlayerUI> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return VisibilityDetector(
      key: Key(widget.url),
      onVisibilityChanged: (info) {
        if (_controller.value.isInitialized) {
          if (info.visibleFraction == 1) {
            _controller.play();
          } else if (info.visibleFraction == 0) {
            _controller.pause();
          }
        }
      },
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          height: size.height,
          width: size.width,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
