import 'package:flutter/material.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

import './widgets/MapOverlay.dart';
import './widgets/MapView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          MapView(
            overlays: [
              MapOverlay(
                  coordinate: LatLng(23.477641, 111.274786),
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.red,
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ))
            ],
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
