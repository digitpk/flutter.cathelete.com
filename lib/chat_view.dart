// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:app/config/config.dart';
//
// class ChatView extends StatefulWidget {
//   @override
//   _ChatViewState createState() => new _ChatViewState();
// }
//
// class _ChatViewState extends State<ChatView> {
//   final GlobalKey webViewKey = GlobalKey();
//
//   bool LoadingScreen = true;
//
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
//
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }
//
//   int progress = 0;
//   bool IsLoadError = false;
//   int IsLoadErrorCode = 0;
//
//   bool pageLoading = true;
//   bool IsLoadingFirstTime = false;
//
//   DateTime currentBackPressTime;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Future<bool> _onBackPressed() async{
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//       if (await _controller.future.canGoBack()) {
//         await _controller.goBack();
//       }
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Are you sure?'),
//           content: Text('Do you want to exit'),
//           actions: <Widget>[
//             // ignore: deprecated_member_use
//             FlatButton(
//               child: Text('No'),
//               onPressed: () => Navigator.of(context).pop(false),
//             ),
//             // ignore: deprecated_member_use
//             FlatButton(
//               child: Text('Yes'),
//               /*Navigator.of(context).pop(true)*/
//               onPressed: () => exit(0),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WillPopScope(
//         onWillPop: _onBackPressed,
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           body: NestedScrollView(
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 if (IsLoadError == true)
//                   SliverAppBar(
//                     automaticallyImplyLeading: false,
//                     backgroundColor: Config().appBarColor,
//                     centerTitle: true,
//                     titleSpacing: 0,
//                     title: Image.asset('assets/images/logo.png',
//                         fit: BoxFit.cover, height: 20),
//                     elevation: 1,
//                     pinned: true,
//                     floating: true,
//                     forceElevated: innerBoxIsScrolled,
//                   ),
//               ];
//             },
//             body: SafeArea(
//               child: Container(
//                 color: Colors.white,
//                 child: Stack(
//                   children: <Widget>[
//                     Expanded(
//                       child: Stack(
//                         children: [
//                           if (progress < 100 &&
//                               IsLoadError == false &&
//                               pageLoading == true &&
//                               IsLoadingFirstTime == false)
//                             Container(
//                               child: Center(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     CircularProgressIndicator(
//                                       backgroundColor: Config().appBarColor,
//                                       valueColor: AlwaysStoppedAnimation(
//                                           Config().appColor),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Container(
//                                       child: Image.asset(
//                                           'assets/images/logo.png',
//                                           fit: BoxFit.cover,
//                                           height: 20),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           IsLoadError == true
//                               ? Container(
//                                   child: Center(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         IsLoadErrorCode == -2
//                                             ? Text('No internet connection',
//                                                 style: TextStyle(
//                                                     color: Colors.grey[800],
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 20))
//                                             : Text('Something went wrong',
//                                                 style: TextStyle(
//                                                     color: Colors.grey[800],
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 20)),
//                                         // ignore: deprecated_member_use
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 30.0),
//                                           // ignore: deprecated_member_use
//                                           child: RaisedButton(
//                                             padding: const EdgeInsets.all(8.0),
//                                             textColor: Colors.white,
//                                             color: Colors.blue,
//                                             onPressed: () async {
//                                               setState(() {
//                                                 progress = 0;
//                                                 pageLoading = true;
//                                                 IsLoadingFirstTime = false;
//                                                 IsLoadErrorCode = 0;
//                                                 IsLoadError = false;
//                                               });
//                                               if (webViewReady) {
//                                                 _controller.reload();
//                                               }
//                                             },
//                                             child: new Text("Try Again"),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               : Opacity(
//                                   opacity: progress < 100 &&
//                                           IsLoadError == false &&
//                                           pageLoading == true &&
//                                           IsLoadingFirstTime == false
//                                       ? 0
//                                       : 1,
//                                   child: WebView(
//                                     initialUrl: 'https://manage.cathelete.com/admin/',
//                                     javascriptMode: JavascriptMode.unrestricted,
//                                     onWebViewCreated: (WebViewController webViewController) {
//                                       _controller.complete(webViewController);
//                                     },
//                                     onProgress: (int _progress) {
//                                       if(_progress < 100){
//                                         setState(() {
//                                           progress = _progress;
//                                         });
//                                       }else{
//                                         setState(() {
//                                           IsLoadingFirstTime = false;
//                                           progress = _progress;
//                                         });
//                                       }
//
//                                     },
//                                     navigationDelegate: (NavigationRequest request) {
//                                       return NavigationDecision.navigate;
//                                     },
//                                     onPageStarted: (String url) {
//                                       setState(() {
//                                         progress = 0;
//                                       });
//                                     },
//                                     onPageFinished: (String url) {
//                                       setState(() {
//                                         IsLoadingFirstTime = false;
//                                         progress = 100;
//                                       });
//                                     },
//                                     gestureNavigationEnabled: true,
//                                   ),
//                                 ),
//                           progress < 100 &&
//                                   IsLoadError == false &&
//                                   pageLoading == true
//                               ? LinearProgressIndicator(
//                                   value: progress/100,
//                                   backgroundColor: Config().appBarColor,
//                                   valueColor:
//                                       AlwaysStoppedAnimation(Config().appColor),
//                                   minHeight: 4,
//                                 )
//                               : Container(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
