# Flutter To-Do App with Back4App Integration

This Flutter To-Do app is developed with Back4App as the backend service for managing tasks. The app allows users to create, update, and delete tasks, and it syncs data with Back4App.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Table of Contents

- [Prerequisites](#prerequisites)
- [Back4App Setup](#back4app-setup)
- [Flutter Installation](#flutter-installation)
- [App Development](#app-development)
- [App Testing](#app-testing)

  
### Prerequisites
Install these as prerequisite:

- Flutter: [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
- Dart: [Dart Installation Guide](https://dart.dev/get-dart)

### Back4App Setup

#### Sign Up for Back4App:
Visit [Back4App](https://www.back4app.com/) and sign up for a new account.
#### Create a New App:
Log in to Back4App and create a new app from the dashboard.
Note the Application ID and Client Key.
Class Creation in Back4App
#### Define Task Class:
In Back4App, create a new class named Task.
Add columns like title (String) and isCompleted (Boolean).

### Flutter Installation

#### Flutter Project Setup:
Create a new Flutter project using the flutter create command.
Open the pubspec.yaml file and add dependencies:
```dart
dependencies:
  back4app_parse_sdk: ^4.2.0
  provider: ^6.1.5
```
Run ```flutter pub get``` to fetch dependencies.

### App Development
#### 1.Initialize Back4App:
Open the ```main.dart``` file and initialize Back4App with Application ID and Client Key.
```dart
void main() async {
  // Back4App initialization code
  runApp(MyApp());
}
```
### 2.Create Task Model:
Defines the ```task_model``` class in ```lib/task_model.dart```.
The Task class encapsulates the properties and behavior of a task in your application. It is designed to be easily serialized and deserialized from JSON, making it suitable for communication with a backend service. Additionally, the class includes methods for easy debugging and representation.
#### 3.Create back4app_service:
This code defines a Dart class Back4AppService that communicates with a Back4App backend to perform CRUD (Create, Read, Update, Delete) operations on tasks. It utilizes the Dio package for making HTTP requests and includes methods to get tasks, create a new task, update a task, and delete a task from the Back4App database. The Task model is used to represent task data.
### 4.Build UI:
This Flutter code defines a simple To-Do app with Back4App integration. It consists of:
#### MyApp Class: The root widget of the application, setting up the MaterialApp.
The theme and primary screen (TaskListScreen) are configured.
#### TaskListScreen Class: A stateful widget displaying a list of tasks fetched from Back4App.
Utilizes Back4AppService to perform CRUD operations on tasks.
Implements methods for fetching, adding, updating, and deleting tasks.
Displays tasks in a ListView with checkboxes for completion status.
Includes a FloatingActionButton for adding new tasks through a dialog.
#### Back4AppService Class: Uses the Dio package for making HTTP requests to the Back4App server.
Includes methods for getting tasks, creating a new task, updating a task, and deleting a task.
The app follows a typical Flutter structure with widgets, state management, and integration with a backend service (Back4App) for task management.

## App Testing
### Run the App:
#### 1. To test this app on an emulator or physical device, need to use ```flutter run```.

<img width="568" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/c65e8c09-afe9-4287-9b39-eeb8b0cc6571">

Initial screen, there is one constant entry which cannot be updated/deleted. It doesn't even store in back4app. ```200 OK``` added earlier which is fetched using ```fetchTask``` when i ran flutter this time. Adding back4app screen to support same

<img width="368" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/26a2238f-68b4-42ab-a554-5213b382a230">

<img width="1440" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/9a3658cf-587a-471e-98e0-608b715e2981">

#### 2. Created a task in todo app and validate the entry in back4app
clicked on ```+``` icon & added the title and pressed add 

<img width="354" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/42461589-6543-4e98-990d-e2112ba6d0a2">

task successfully added

<img width="360" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/cb0e412b-dbce-4b09-8ce8-de6b7f1f59ff">

entry successfully logged in back4app as well

<img width="1439" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/0eb87d91-f12a-4bf1-9526-a885248f3fa5">

#### 3. update/delete a task in todo app and validate the entry being deleted in back4app
checked the checkbox & after 1sec, entry got deleted

<img width="368" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/8f982152-d7ab-486a-a5bb-b9731e19746d">

entry successfully deleted in back4app as well

<img width="1439" alt="image" src="https://github.com/S-Jyothsna-Reddy/todolist/assets/99994325/e420aca2-21b0-4cde-b027-c9a501b10bcd">



