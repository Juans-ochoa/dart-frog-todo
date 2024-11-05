import '../models/task_model.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  GetTasksUseCase(this.repository);

  final TaskRepository repository;

  Future<List<TaskModel>> call() async {
    return repository.getAllTasks();
  }
}
