import '../repositories/task_repository.dart';

class DeleteTaskUseCase {
  DeleteTaskUseCase(this.repository);

  final TaskRepository repository;

  Future<String> call(String id) async {
    return repository.deleteTask(id);
  }
}
