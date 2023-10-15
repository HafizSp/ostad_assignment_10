import 'package:flutter/material.dart';
import 'package:ostad_assignment_10/todo.dart';

class UpdateTodo extends StatefulWidget {
  const UpdateTodo({super.key, required this.todo, required this.onTodoUpdate});

  final Todo todo;
  final Function(String, String) onTodoUpdate;

  @override
  State<UpdateTodo> createState() => _UpdateTodoState();
}

class _UpdateTodoState extends State<UpdateTodo> {
  late TextEditingController updateTitleTEController =
      TextEditingController(text: widget.todo.todoTitle);
  late TextEditingController updateDescriptionTEController =
      TextEditingController(text: widget.todo.todoDescription);
  final GlobalKey<FormState> updateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: updateKey,
        child: Column(
          children: [
            TextFormField(
              controller: updateTitleTEController,
              decoration: const InputDecoration(
                hintText: 'Edit Title',
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.blue),
                ),
              ),
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter Title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: updateDescriptionTEController,
              decoration: const InputDecoration(
                hintText: 'Edit Description',
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
            ElevatedButton(
                onPressed: () {
                  if (updateKey.currentState!.validate()) {
                    widget.onTodoUpdate(updateTitleTEController.text.trim(),
                        updateDescriptionTEController.text.trim());
                    Navigator.pop(context);
                  }
                },
                child: const Text('Edit Done'))
          ],
        ),
      ),
    );
  }
}
