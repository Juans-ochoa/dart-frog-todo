import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class CreateTaskUseCase {
  CreateTaskUseCase(this.repository);

  final TaskRepository repository;

  Future<TaskModel> call(
    String title,
    String description,
    String urlImage,
  ) {
    final task = TaskModel(
      title: title,
      urlImage: urlImage,
      description: description,
    );

    return repository.createTask(task);
  }
}
