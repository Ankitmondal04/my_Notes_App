import 'package:flutter/material.dart';
import 'package:my_notes/data/repositories/todoRepo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool isPriority = false;
  bool isUndone = false;

  List<Map<String, dynamic>> allTasks = [];

  TodoRepo? allMyTasks;

  @override
  void initState() {
    super.initState();
    allMyTasks = TodoRepo();
    getTasks();
  }

  void getTasks() async {
    allTasks = await allMyTasks!.getAllTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text("My Tasks"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.book_rounded),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 4.0,
                children: <Widget>[
                  Chip(
                    label: Text("Today's Tasks"),
                    backgroundColor: Colors.amberAccent,
                  ),
                  Chip(
                    label: Text("Priority Tasks"),
                    backgroundColor: Colors.lightGreenAccent,
                  ),
                  Chip(
                    label: Text("Not Completed"),
                    backgroundColor: Colors.redAccent,
                  ),
                  Chip(
                    label: Text("Not Completed"),
                    backgroundColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 5,
            endIndent: 5,
            color: Colors.brown,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {
                        (allTasks[index][TodoRepo.columnStatus] == 0) ? 1 : 0;
                      },
                      icon: Icon(
                        (allTasks[index][TodoRepo.columnStatus] == 1)
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank_outlined,
                      ),
                    ),
                    title: Text("${allTasks[index][TodoRepo.columnTasks]}"),
                    trailing: IconButton(
                      onPressed: () async {
                        bool isDeleted = await allMyTasks!.deleteTask(
                          SnO: allTasks[index][TodoRepo.columnSnO],
                        );
                        if (isDeleted) {
                          allTasks = await allMyTasks!.getAllTasks();
                        }
                        setState(() {});
                      },
                      icon: Icon(Icons.delete),
                    ),
                    tileColor: Colors.amber,
                    onTap: () {},
                  ),
                );
              }),
              itemCount: allTasks.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTasksDialog();
        },
        child: Icon(Icons.add_task),
      ),
    );
  }

  void _addTasksDialog() {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Tasks"),
          titleTextStyle: TextStyle(
            fontFamily: 'Capriola',
            fontSize: 20.0,
            color: Color(0xFF4E342E),
          ),
          content: TextField(
            controller: taskController,
            autofocus: true,
            decoration: const InputDecoration(hintText: "Enter Task "),
          ),
          elevation: 10.0,
          backgroundColor: Color(0xFFE0D3AF),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (taskController.text.isNotEmpty) {
                  bool isEntered = await allMyTasks!.addTasks(
                    myTasks: taskController.text,
                  );
                  if (isEntered) {
                    allTasks = await allMyTasks!.getAllTasks();
                  }
                  setState(() {});
                }
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
