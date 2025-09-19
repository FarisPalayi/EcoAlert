import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DocumentWebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const DocumentWebViewScreen({super.key, required this.title, required this.url});

  @override
  State<DocumentWebViewScreen> createState() => _DocumentWebViewScreenState();
}

class _DocumentWebViewScreenState extends State<DocumentWebViewScreen> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => setState(() => _loading = false),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_loading) const LinearProgressIndicator(minHeight: 2),
        ],
      ),
    );
  }
}
