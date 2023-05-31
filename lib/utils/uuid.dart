import 'package:uuid/uuid.dart';

String getUuid() {
  const uuid = Uuid();
  // IDを生成する
  return uuid.v4();
}
