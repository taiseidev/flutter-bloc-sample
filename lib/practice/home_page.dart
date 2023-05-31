import 'dart:async';

import 'package:bloc_sample/practice/business_logic.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  var intController = StreamController<int>();
  var stringController = StreamController<String>.broadcast();

  // 初期化時にConsumerのコンストラクタにStreamを渡す
  @override
  void initState() {
    super.initState();
    Generator(intController);
    Coordinator(intController, stringController);
    Consumer(stringController);
  }

  // 終了時にStreamを解放する
  @override
  void dispose() {
    super.dispose();
    intController.close();
    stringController.close();
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
              'ランダムで数字を表示する',
            ),
            StreamBuilder(
              stream: stringController.stream,
              initialData: '0',
              builder: (context, snapshot) {
                final data = snapshot.data;
                return Text(
                  '$data',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
