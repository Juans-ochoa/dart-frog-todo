import 'package:mongo_dart/mongo_dart.dart';

class TaskModel {
  TaskModel({
    required this.title,
    required this.urlImage,
    required this.description,
    this.id,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['_id'] as ObjectId,
      title: map['title'] as String,
      urlImage: map['urlImage'] as String,
      description: map['description'] as String,
    );
  }

  TaskModel copyWith({
    String? title,
    String? urlImage,
    String? description,
    ObjectId? id,
  }) {
    return TaskModel(
      title: title ?? '',
      urlImage: urlImage ?? '',
      description: description ?? '',
      id: id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      'title': title,
      'urlImage': urlImage,
      'description': description,
    };
  }

  final ObjectId? id;
  final String title;
  final String urlImage;
  final String description;
}
