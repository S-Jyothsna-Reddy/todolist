class Task {
  final String objectId;
  final String title;
  bool _isCompleted;

  Task({
    required this.objectId,
    required this.title,
    required bool isCompleted,
  }) : _isCompleted = isCompleted;

  // Getter for isCompleted
  bool get isCompleted => _isCompleted;

  // Setter for isCompleted
  set isCompleted(bool value) {
    _isCompleted = value;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    print('JSON response: $json');

    return Task(
      objectId: json['objectId'] ?? '',
      title: json['title'] ?? 'This is default one & wont be deleted',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Task{objectId: $objectId, title: $title, isCompleted: $isCompleted}';
  }
}
