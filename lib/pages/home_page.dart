import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Model/todoList.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/provider/user_provider.dart';

import 'package:todolist/util/createDialog.dart';
import 'package:todolist/util/editDialog.dart';

class HomePage extends StatefulWidget {
  // final int userId;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final provider = UserProvider();
  // final String  searchTask = searchController.text;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      Provider.of<TaskProvider>(context, listen: false)
          .searchTasks(searchController.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CreateDialog();
            },
          );
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 31, 30, 30),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          final lists = provider.taskLists;

          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        label: const Text("Search"),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  lists.isEmpty
                      ? const Expanded(
                          child: Center(child: Text("No Task Found")),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: lists.length,
                            itemBuilder: (context, index) {
                              final list = lists[index];
                              final int listID = list['id'];

                              bool isDone;
                              if (list['isDone'] == 0) {
                                isDone = false;
                              } else {
                                isDone = true;
                              }

                              final date = DateTime.parse(list['date']);
                              final formattedDate =
                                  DateFormat('dd/MM/yyyy').format(date);

                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red,
                                      onPressed: (context) {
                                        provider.deleteTask(listID);
                                        DelightToastBar(
                                          autoDismiss: true,
                                          builder: (context) => const ToastCard(
                                            leading: Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 28,
                                            ),
                                            title: Text(
                                              "Task deleted successfully",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          snackbarDuration:
                                              Durations.extralong4,
                                        ).show(context);
                                      },
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    const SizedBox(width: 5),
                                    SlidableAction(
                                      borderRadius: BorderRadius.circular(15),
                                      icon: Icons.edit,
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.orangeAccent,
                                      onPressed: (context) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Editdialog(
                                              task: list['task'],
                                              date: date,
                                              id: listID,
                                              isDone: list['isDone'],
                                              userId: list['user_id'],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      list['task'],
                                      style: TextStyle(
                                        decoration: isDone
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    subtitle: Text(formattedDate),
                                    trailing: Checkbox(
                                      activeColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      value: isDone,
                                      onChanged: (value) {
                                        if (value != null) {
                                          final int isDoneValue = value ? 1 : 0;

                                          final updatedTask = Todolist(
                                              task: list['task'],
                                              date: date,
                                              isDone: isDoneValue,
                                              user_id: list['user_id']);

                                          // Update the task in the provider
                                          provider.updateTask(
                                              listID, updatedTask);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
