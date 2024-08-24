import '../core/utils.dart';

class TaskModel {
  static const String collectionName = "TasksCollection";
  String? id;
  String title;
  String description;
  DateTime selectedDate;
  bool isDone;
  String? userUid;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.selectedDate,
    this.isDone = false,
    this.userUid,
  });

  factory TaskModel.firestore(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      selectedDate: json["selectedDate"] is int
          ? DateTime.fromMillisecondsSinceEpoch(json["selectedDate"])
          : DateTime.parse(json["selectedDate"]),
      isDone: json["isDone"] is String
          ? json["isDone"].toUpercase() == 'true'
          : json["isDone"] as bool,
      userUid: json["userUid"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "selectedDate": extractDate(selectedDate).millisecondsSinceEpoch,
      "isDone": isDone,
      "userUid": userUid,
    };
  }
}
