import 'package:mongo_dart/mongo_dart.dart';

import '../models/task_model.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(DbCollection dbCollection) : _dbCollection = dbCollection;

  final DbCollection _dbCollection;

  @override
  Future<TaskModel> getTaskById(String id) async {
    try {
      final result =
          await _dbCollection.findOne(where.id(ObjectId.fromHexString(id)));

      if (result != null) {
        return TaskModel.fromMap(result);
      } else {
        throw Exception('Task not found with id: $id');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final taskMap = await _dbCollection.find().toList();

      return taskMap.map(TaskModel.fromMap).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      final result = await _dbCollection.insertOne(task.toMap());
      print(result.isSuccess);

      if (result.isSuccess) {
        return TaskModel.fromMap(result.document!);
      } else {
        throw Exception('Failed to insert task');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task, String id) async {
    try {
      final result = await _dbCollection.replaceOne(
        where.id(ObjectId.fromHexString(id)),
        task.toMap(),
      );

      if (result.isSuccess) {
        return task;
      } else {
        throw Exception('Error to update task with id ${task.id}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> deleteTask(String id) async {
    try {
      final result =
          await _dbCollection.deleteOne(where.id(ObjectId.fromHexString(id)));
      if (!result.isSuccess) {
        throw Exception('Error to delete task with id: $id');
      }

      return 'Task with id: $id was delete successfully';
    } catch (e) {
      throw Exception(e);
    }
  }
}
