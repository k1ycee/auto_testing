import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamController<int> controller = StreamController<int>.broadcast();
  late StreamSubscription<int> _streamSubscription;
  int _counter = 0;
  int streamCounter = 0;

  Stream<int> incrementCounter() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield streamCounter += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            key: const ValueKey('counterText'),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () async {
             _streamSubscription = incrementCounter().listen((event) {
                setState(() {
                  _counter = event;
                });
              });
            },
            tooltip: 'Play',
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            backgroundColor: Colors.yellow,
            onPressed: () async {
              _streamSubscription.pause();
            },
            tooltip: 'Pause',
            child: const Icon(
              Icons.pause,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () async {
             _streamSubscription.cancel();
            },
            tooltip: 'Stop',
            child: const Icon(
              Icons.stop,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
