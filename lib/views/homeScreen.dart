import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    refreshController = PullToRefreshController(
        onRefresh: () {
          inAppWebViewController!.reload();
        },
        settings: PullToRefreshSettings(
          color: Colors.white,
          backgroundColor: Colors.red,
        ));
  }

  String url = "https://ustvnow360.com/";
  InAppWebViewController? inAppWebViewController;
  bool? isloading = false;
  PullToRefreshController? refreshController;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await inAppWebViewController!.canGoBack()) {
          inAppWebViewController!.goBack();
        } else {
          SystemNavigator.pop();
        }

        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  InAppWebView(
                    onConsoleMessage: (controller, consoleMessage) {},
                    pullToRefreshController: refreshController,
                    onLoadStart: (inAppWebViewController, url) {
                      setState(() {
                        isloading = true;
                      });
                    },
                    onLoadStop: (inAppWebViewController, url) {
                      setState(() {
                        isloading = false;
                      });
                      refreshController!.endRefreshing();
                    },
                    onWebViewCreated: (controller) =>
                        inAppWebViewController = controller,
                    initialUrlRequest: URLRequest(url: WebUri(url)),
                  ),
                  Visibility(
                      visible: isloading!,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                      ))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
