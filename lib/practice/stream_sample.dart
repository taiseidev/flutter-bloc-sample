import 'dart:async';

import 'package:flutter/material.dart';

class StreamSample extends StatefulWidget {
  const StreamSample({super.key, required this.title});

  final String title;

  @override
  State<StreamSample> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StreamSample> {
  int _counter = 0;
  // Stream
  final _counterStream = StreamController<int>();

  // 初期化時にConsumerのコンストラクタにStreamを渡す
  @override
  void initState() {
    super.initState();
    Consumer(_counterStream);
  }

  // 終了時にStreamを解放する
  @override
  void dispose() {
    super.dispose();
    _counterStream.close();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    // カウントアップした後に、Streamにカウンタ値を流す
    _counterStream.sink.add(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Consumer {
  Consumer(StreamController<int> consumeStream) {
    // Streamをlistenしてデータが来たらターミナルに表示する
    consumeStream.stream.listen((data) async {
      debugPrint(data.toString());
    });
  }
}
