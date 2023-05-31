class Todo {
  // 一意のID
  final String id;

  // タイトル
  final String title;

  // 内容
  final String description;

  // 作成日時
  final DateTime createdAt;

  // 完了フラグ
  bool isComplete;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.isComplete = false,
  });

  // todoの更新
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isComplete,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  // デシリアライズ
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      isComplete: json['isComplete'],
    );
  }

  // シリアライズ
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'isComplete': isComplete,
    };
  }
}
