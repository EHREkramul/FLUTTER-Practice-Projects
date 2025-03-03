import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Lite',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late InAppWebViewController _inAppWebViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool isPop) async {
        if (isPop) return;

        if (await _inAppWebViewController.canGoBack()) {
          _inAppWebViewController.goBack();
        } else {
          exit(0);
        }
      },
      child: Scaffold(
        appBar:
        MediaQuery.of(context).orientation == Orientation.landscape
            ? null
            : AppBar(
          title: const Text('Youtube Lite'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () async {
                if (await _inAppWebViewController.canGoBack()) {
                  _inAppWebViewController.goBack();
                }
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ],
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri('https://www.youtube.com/watch?v=xd8dKY6Ozrg'),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  supportZoom: false,
                ),
              ),
              onWebViewCreated: (controller) {
                _inAppWebViewController = controller;
              },
              onLoadStop: (controller, url) {
                setState(() {
                  progress = 1.0;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress =
                      progress / 100; // Corrected progress calculation
                });
              },
            ),
            if (progress < 1.0)
              LinearProgressIndicator(
                value: progress,
                color: Colors.green,
                backgroundColor: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}
