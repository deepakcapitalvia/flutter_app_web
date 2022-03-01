import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void dispose() {
    flutterWebviewPlugin.cleanCookies();
    flutterWebviewPlugin.dispose();
    flutterWebviewPlugin.close();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget launchURL(String _url, BuildContext context) {
    flutterWebviewPlugin.onDestroy.listen((_) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    });

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      var redirected_uri = Uri.parse(url);
      print("rdire url is $redirected_uri");

      if (redirected_uri.toString().contains("google.com")) {
        print("success");

        flutterWebviewPlugin.close();
      }
      print("ERROR GETTING Token!!!");
      print(redirected_uri);
      return;
    });
    Color mainColor = Color.fromRGBO(0, 95, 184, 1);
    return new WebviewScaffold(
      withJavascript: true,
      url: _url,
      allowFileURLs: true,
      appBar: new AppBar(
        leading: Container(
          margin: const EdgeInsets.only(left: 5.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: Colors.black,
            ),
            //  onPressed: () => _scaffoldKey.currentState.openDrawer(),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Service Agreement",
          style: TextStyle(color: Colors.black, fontSize: 17.0),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      withZoom: true,
      withLocalStorage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          launchURL("https://www.google.com", context)),
                );
              },
              child: const Text('One'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          launchURL("https://www.google.com", context)),
                );
              },
              child: const Text('Two'),
            ),
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
