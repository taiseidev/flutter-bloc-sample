import 'dart:async';
import "dart:math" as math;

import 'package:flutter/material.dart';

// データを生成するクラス
class Generator {
  Generator(StreamController<int> controller) {
    Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        // 10秒ごとに実行する処理
        final data = math.Random().nextInt(100);
        debugPrint('Generator: $data');
        controller.sink.add(data);
      },
    );
  }
}

// データの加工を担当するクラス
class Coordinator {
  Coordinator(StreamController<int> intController,
      StreamController<String> stringController) {
    intController.stream.listen(
      (data) {
        // int型のデータを受け取ったら、String型に変換してStreamに流す
        final convertedData = data.toString();
        debugPrint('Coordinator: $convertedData');
        stringController.sink.add(convertedData);
      },
    );
  }
}

// データの利用を担当
class Consumer {
  Consumer(StreamController<String> controller) {
    controller.stream.listen(
      (data) async {
        // String型のデータを受け取ったら、ターミナルに表示する
        debugPrint('Consumer: $data');
      },
    );
  }
}
