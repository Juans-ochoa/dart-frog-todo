import 'package:mongo_dart/mongo_dart.dart';

import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUseCase {
  UpdateTaskUseCase(this.repository);

  final TaskRepository repository;

  Future<TaskModel> call(
    String id,
    String title,
    String description,
    String urlImage,
  ) async {
    final task = TaskModel(
      title: title,
      urlImage: urlImage,
      description: description,
      id: ObjectId.fromHexString(id),
    );

    return repository.updateTask(task, id);
  }
}
