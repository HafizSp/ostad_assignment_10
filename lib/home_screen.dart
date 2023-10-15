import 'package:flutter/material.dart';
import 'package:ostad_assignment_10/todo.dart';
import 'package:ostad_assignment_10/update_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleTEController = TextEditingController();
  final TextEditingController descriptionTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Todo> todos = [];

  void addTodo(Todo todo) {
    todos.add(todo);
    setState(() {});
  }

  void deleteTodo(int index) {
    todos.removeAt(index);
    setState(() {});
  }

  void updateTodo(int index, String todoTitle, String todoDescription) {
    todos[index].todoTitle = todoTitle;
    todos[index].todoDescription = todoDescription;
    setState(() {});
  }

  void showAlertDialog(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return UpdateTodo(
                              todo: todos[index],
                              onTodoUpdate:
                                  (String todoTitle, String todoDescription) {
                                updateTodo(index, todoTitle, todoDescription);
                              },
                            );
                          },
                        );
                      },
                      child: const Text('Edit')),
                  TextButton(
                      onPressed: () {
                        deleteTodo(index);
                        Navigator.pop(context);
                      },
                      child: const Text('Delete')),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(children: [
                TextFormField(
                  controller: titleTEController,
                  decoration: const InputDecoration(
                    hintText: 'Add Title',
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionTEController,
                  decoration: const InputDecoration(
                    hintText: 'Add Description',
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Todo todo = Todo(
                            todoTitle: titleTEController.text.trim(),
                            todoDescription:
                                descriptionTEController.text.trim());
                        addTodo(todo);
                        titleTEController.clear();
                        descriptionTEController.clear();
                      }
                    },
                    child: const Text('Add')),
              ]),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                  itemCount: todos.length,
                  itemExtent: 80,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onLongPress: () {
                          showAlertDialog(index);
                        },
                        tileColor: Colors.black12,
                        title: Text(todos[index].todoTitle),
                        subtitle: Text(todos[index].todoDescription),
                        leading: const CircleAvatar(),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
