import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/data/repositories/notesRepo.dart';
import 'package:my_notes/screens/textEditing_screen.dart';
import 'package:my_notes/screens/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> allNotes = [];

  NotesRepo? allNotesData;

  @override
  void initState() {
    super.initState();
    allNotesData = NotesRepo();
    getNotes();
  }

  void getNotes() async {
    allNotes = await allNotesData!.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Color(0xFF4E342E)),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoScreen()),
              );
            },
            icon: Icon(Icons.task_alt_rounded, color: Color(0xFF4E342E)),
          ),
        ],
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFFF5DEB3),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader(
            //   decoration: BoxDecoration(color: Color(0xFFE8D3BE)),
            //   child: Text('Menu'),
            // ),
            Container(height: 100, color: Colors.amberAccent),
            Card(
              color: Color(0xFFF4C430),
              child: ListTile(title: Text('Settings')),
            ),
            Card(
              color: Color(0xFFF4C430),
              child: ListTile(title: Text('My Data')),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                itemCount: allNotes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemBuilder: ((context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () async {
                        final isUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TexteditingScreen(
                              notesTable: allNotesData!,
                              note: allNotes[allNotes.length - index - 1],
                            ),
                          ),
                        );
                        if (isUpdated == true) {
                          getNotes();
                        }
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE0D3AF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black45, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFB8AE9D),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                          // borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            Text(
                              //Title
                              allNotes[allNotes.length -
                                  index -
                                  1][NotesRepo.columnTitle],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Capriola',
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                //Content
                                allNotes[allNotes.length -
                                    index -
                                    1][NotesRepo.columnText],
                                maxLines: 3,
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat("dd MMM, HH:mm").format(
                                      DateTime.parse(
                                        allNotes[allNotes.length -
                                            index -
                                            1][NotesRepo
                                            .columnDateTime], //.toString()
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Bitcount',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () async {
                                      if (allNotes[allNotes.length -
                                              index -
                                              1][NotesRepo.columnText] !=
                                          null) {
                                        bool deleted = await allNotesData!
                                            .deleteNote(
                                              dateModified:
                                                  allNotes[allNotes.length -
                                                      index -
                                                      1][NotesRepo
                                                      .columnDateTime],
                                            );
                                        if (deleted) {
                                          getNotes();
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TexteditingScreen(notesTable: allNotesData!),
            ),
          );
          if (result == true) {
            getNotes();
          }
        },
        child: Icon(Icons.add, color: Color(0xFF4E342E), weight: 50, fill: 1.0),
      ),
    );
  }
}
