import 'package:flutter/material.dart';
import 'back4app_service.dart';
import 'task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  //const TaskListScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final Back4AppService back4AppService = Back4AppService();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    try {
      List<Task> fetchedTasks = await back4AppService.getTasks();
      setState(() {
        tasks = fetchedTasks;
      });
    } catch (e) {
      // Handle error
      print('Error fetching tasks: $e');
    }
  }

  void addTask(String title) async {
    try {
      Task? newTask = await back4AppService.createTask(title);
      print('New task created: $newTask');
      await Future.delayed(const Duration(milliseconds: 100)); // Add a delay
      setState(() {
        tasks.add(newTask!);
      });
    } catch (e) {
      // Handle error
      print('Error creating task: $e');
    }
  }

  void updateTask(Task task) async {
    try {
      Task updatedTask = await back4AppService.updateTask(task);

      setState(() {
        // Find the index of the task to be updated
        int index = tasks.indexWhere((t) => t.objectId == updatedTask.objectId);

        if (index != -1) {
          // If the task is found, update it
          tasks[index] = updatedTask;
        } else {
          // If the task is not found, add it to the list
          tasks.add(updatedTask);
        }
      });
    } catch (e) {
      // Handle error
      print('Error updating task: $e');
    }
  }

  void deleteTask(String objectId) async {
    try {
      await back4AppService.deleteTask(objectId);
      setState(() {
        tasks.removeWhere((task) => task.objectId == objectId);
      });
    } catch (e) {
      // Handle error
      print('Error deleting task: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Todo List"),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) async {
                task.isCompleted = value ?? false;
                updateTask(Task(
                  objectId: task.objectId,
                  title: task.title,
                  isCompleted: value ?? false,
                ));
                // If the checkbox is checked, wait for 1 second (adjust as needed) and then delete the task
                if (value == true) {
                  await Future.delayed(
                      const Duration(seconds: 1)); // Adjust the delay as needed
                  deleteTask(task.objectId);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController controller = TextEditingController();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: 'Task Title'),
                  onSubmitted: (value) {
                    addTask(value);
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      addTask(controller.text);
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
