import '../models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel> getTaskById(String id);
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task, String id);
  Future<String> deleteTask(String id);
}
