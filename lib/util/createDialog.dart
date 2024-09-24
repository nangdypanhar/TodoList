import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Model/todoList.dart';
import 'package:todolist/provider/task_provider.dart';

class CreateDialog extends StatelessWidget {
  const CreateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController dateController = TextEditingController();
    TextEditingController taskController = TextEditingController();
    DateTime? selectedDate;

    return AlertDialog(
      title: const Text("Add New Task"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: taskController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please input the task";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: const Text("Enter a task"),
                prefixIcon: const Icon(Icons.track_changes),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: dateController,
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  selectedDate = pickedDate;
                  dateController.text =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select the Date";
                }
                return null;
              },
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                label: const Text("Set the date"),
                prefixIcon: const Icon(Icons.date_range),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newList = Todolist(
                      task: taskController.text,
                      date: selectedDate,
                      isDone: 0,
                      user_id: 1);
                  final provider =
                      Provider.of<TaskProvider>(context, listen: false);
                  provider.addTask(newList);
                  DelightToastBar(
                    autoDismiss: true,
                    builder: (context) => const ToastCard(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 28,
                      ),
                      title: Text(
                        "Task add successfully",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    snackbarDuration: Durations.extralong4,
                  ).show(context);
                  Navigator.of(context).pop();
                } else {
                  print("Form validation failed");
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              ),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
