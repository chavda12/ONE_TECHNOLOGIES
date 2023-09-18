import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:videoplay/src/ui/player_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<String> urls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://media.w3.org/2010/05/sintel/trailer.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber.shade300,
        body: PreloadPageView.builder(
          itemCount: urls.length,
          preloadPagesCount: 3,
          itemBuilder: (context, index) {
            return PlayerUI(url: urls[index]);
          },
        ),
      ),
    );
  }
}
