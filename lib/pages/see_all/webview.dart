import 'package:coar/constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayTutorialScreen extends StatefulWidget {
  const PlayTutorialScreen({super.key});

  @override
  _PlayTutorialScreenState createState() => _PlayTutorialScreenState();
}

class _PlayTutorialScreenState extends State<PlayTutorialScreen> {
  late WebViewController _webViewController;
  bool _isError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();

    // For Android platform initialization (Hybrid Composition)
    if (WebView.platform is AndroidWebView) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    // Dispose the WebViewController if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const googleDriveUrl =
        'https://www.candere.com/heavenly-delight-pearl-diamond-necklace.html';

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        surfaceTintColor: whiteColor,
        backgroundColor: whiteColor,
        title: const Text('Play Tutorial'),
      ),
      body: Column(
        children: [
          _isError
              ? Center(
                  child: Text('Error: $_errorMessage'),
                )
              : Expanded(
                  child: WebView(
                    initialUrl: googleDriveUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _webViewController = webViewController;
                    },
                    onPageFinished: (String url) {
                      // You can add any action here when the page is fully loaded
                    },
                    onWebResourceError: (error) {
                      setState(() {
                        _isError = true;
                        _errorMessage = error.description;
                      });
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
