import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class GetTaskByIdUseCase {
  GetTaskByIdUseCase(this.repository);

  final TaskRepository repository;

  Future<TaskModel> call(String id) async {
    return repository.getTaskById(id);
  }
}
