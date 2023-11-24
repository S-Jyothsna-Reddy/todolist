import 'package:dio/dio.dart';
import 'task_model.dart';

class Back4AppService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://parseapi.back4app.com/',
    headers: {
      'X-Parse-Application-Id': 'wRSG580nG1cyKAXazvI6KgL8GBLHeQXK7JCKISgb',
      'X-Parse-Client-Key': 'OSSbI6Z8FqQYW7mLfTBfl33GGH71IQJmnk30UcSr',
      'Content-Type': 'application/json',
    },
  ));

  Future<List<Task>> getTasks() async {
    try {
      final response = await dio.get('/classes/Tasks');
      final List<dynamic> data = response.data['results'];
      return data.map((task) => Task.fromJson(task)).toList();
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task?> createTask(String title) async {
    try {
      if (title == null ||
          title.isEmpty ||
          title == 'default_title' ||
          title == '') {
        print('Invalid title: $title. Task not created.');
        // You can return null or throw an exception, depending on your use case.
        return null;
      }

      print('Creating task: $title');

      final response = await dio.post('/classes/Tasks', data: {
        'title': title,
        'isCompleted': false,
      });

      print('Task created: ${response.data}');
      // Use response.data to access the JSON data
      Map<String, dynamic> responseData = response.data;

      // Include 'title' when creating Task object
      return Task(
        objectId: responseData['objectId'],
        title: title,
        isCompleted: responseData['isCompleted'] ?? false,
      );
    } catch (e) {
      print('Error creating task: $e');
      throw Exception('Failed to create task');
    }
  }

  Future<Task> updateTask(Task task) async {
    try {
      final response = await dio.put('/classes/Tasks/${task.objectId}', data: {
        'title': task.title,
        'isCompleted': task.isCompleted,
      });
      print('Update response: $response');
      return Task.fromJson(response.data);
    } catch (e) {
      print('Error creating task: $e');
      throw Exception('Failed to create task');
    }
  }

  Future<void> deleteTask(String objectId) async {
    try {
      await dio.delete('/classes/Tasks/$objectId');
    } catch (e) {
      throw Exception('Failed to delete task');
    }
  }
}
