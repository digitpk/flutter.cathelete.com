import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:app/config/config.dart';

class CatheleteNewsPage extends StatefulWidget {
  @override
  _CatheleteNewsPageState createState() => new _CatheleteNewsPageState();
}

class _CatheleteNewsPageState extends State<CatheleteNewsPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        databaseEnabled: true,
        domStorageEnabled: true,
        useWideViewPort: false,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController pullToRefreshController;
  ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  bool IsLoadError = false;
  int IsLoadErrorCode = 0;

  int _currentPage = 0;
  final _pageController = PageController();

  bool IsPageLoading = true;
  bool pageLoading = true;
  bool IsLoadingFirstTime = false;
  bool LoadingScreen = true;

  DateTime currentBackPressTime;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Config().appColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 1)) {
      currentBackPressTime = now;
      webViewController?.goBack();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit'),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text('Yes'),
              /*Navigator.of(context).pop(true)*/
              onPressed: () => exit(0),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Config().appColor,
          drawerScrimColor: Config().appColor,
          resizeToAvoidBottomInset: false,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[];
            },
            body: SafeArea(
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    if (progress < 1.0 &&
                        IsLoadError == false &&
                        pageLoading == true &&
                        IsLoadingFirstTime == false)
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                backgroundColor: Config().appBarColor,
                                valueColor:
                                    AlwaysStoppedAnimation(Config().appColor),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Image.asset(
                                    'assets/images/cathelete_logo.png',
                                    fit: BoxFit.cover,
                                    height: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    IsLoadError == true
                        ? Container(
                            color: Colors.white,
                            height: 45,
                            child: Center(
                              child: Image.asset(
                                  'assets/images/cathelete_logo.png',
                                  fit: BoxFit.cover,
                                  height: 20),
                            ),
                          )
                        : Container(),
                    IsLoadError == true
                        ? SizedBox(
                            height: 20,
                          )
                        : Container(),
                    IsLoadError == true
                        ? Container(
                            margin: EdgeInsets.only(top: 45),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IsLoadErrorCode == -2
                                      ? Text('No internet connection',
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
                                      : Text('Something went wrong',
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                  // ignore: deprecated_member_use
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      padding: const EdgeInsets.all(8.0),
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                      onPressed: () async {
                                        if (Platform.isAndroid) {
                                          webViewController.reload();
                                        } else if (Platform.isIOS) {
                                          webViewController?.loadUrl(
                                              urlRequest: URLRequest(
                                                  url: await webViewController
                                                      ?.getUrl()));
                                        }
                                        setState(() {
                                          progress = 0.0;
                                          pageLoading = true;
                                          IsLoadingFirstTime = false;
                                          IsLoadErrorCode = 0;
                                          IsLoadError = false;
                                        });
                                      },
                                      child: new Text("Try Again"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Opacity(
                            opacity: progress < 1.0 &&
                                    IsLoadError == false &&
                                    pageLoading == true &&
                                    IsLoadingFirstTime == false
                                ? 0
                                : 1,
                            child: InAppWebView(
                              key: webViewKey,
                              initialUrlRequest: URLRequest(
                                  url: Uri.parse(Config()
                                      .webView['cathelete_news']['url'])),
                              initialUserScripts:
                                  UnmodifiableListView<UserScript>([]),
                              initialOptions: options,
                              pullToRefreshController: pullToRefreshController,
                              onWebViewCreated: (controller) {
                                webViewController = controller;
                              },
                              onLoadStart: (controller, url) {
                                setState(() {
                                  pageLoading = true;
                                  this.url = url.toString();
                                  urlController.text = this.url;
                                });
                              },
                              androidOnPermissionRequest:
                                  (controller, origin, resources) async {
                                return PermissionRequestResponse(
                                    resources: resources,
                                    action:
                                        PermissionRequestResponseAction.GRANT);
                              },
                              shouldOverrideUrlLoading:
                                  (controller, navigationAction) async {
                                var uri = navigationAction.request.url;

                                return NavigationActionPolicy.ALLOW;
                              },
                              onLoadStop: (controller, url) async {
                                pullToRefreshController.endRefreshing();
                                setState(() {
                                  IsLoadingFirstTime = true;
                                  pageLoading = false;
                                  this.url = url.toString();
                                  urlController.text = this.url;
                                });
                              },
                              onLoadError: (controller, url, code, message) {
                                setState(() {
                                  IsLoadingFirstTime = true;
                                  IsLoadErrorCode = code;
                                  IsLoadError = true;
                                });
                                pullToRefreshController.endRefreshing();
                              },
                              onProgressChanged: (controller, progress) {
                                if (progress == 100) {
                                  setState(() {
                                    IsLoadingFirstTime = true;
                                    pageLoading = false;
                                    this.progress = progress / 100;
                                    urlController.text = this.url;
                                  });
                                  pullToRefreshController.endRefreshing();
                                } else {
                                  setState(() {
                                    this.progress = progress / 100;
                                    urlController.text = this.url;
                                  });
                                }
                              },
                              onUpdateVisitedHistory:
                                  (controller, url, androidIsReload) {
                                setState(() {
                                  this.url = url.toString();
                                  urlController.text = this.url;
                                });
                              },
                              onConsoleMessage: (controller, consoleMessage) {
                                print(consoleMessage);
                              },
                            ),
                          ),
                    progress < 1.0 &&
                            IsLoadError == false &&
                            pageLoading == true
                        ? LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Config().appBarColor,
                            valueColor:
                                AlwaysStoppedAnimation(Config().appColor),
                            minHeight: 4,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
