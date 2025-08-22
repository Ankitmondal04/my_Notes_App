import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notes/data/repositories/notesRepo.dart';
import 'package:my_notes/stateManager/generative_ai_services.dart';

class TexteditingScreen extends StatefulWidget {
  final NotesRepo notesTable;

  final Map<String, dynamic>? note;

  const TexteditingScreen({super.key, required this.notesTable, this.note});

  @override
  State<TexteditingScreen> createState() => _TexteditingScreenState();
}

class _TexteditingScreenState extends State<TexteditingScreen> {
  DateTime currentDateTime = DateTime.now();
  final GenerativeAi generativeAi = GenerativeAi();

  String get dateModified =>
      DateFormat('dd MMM, HH:mm').format(currentDateTime);

  TextEditingController titleController = TextEditingController();
  TextEditingController textController = TextEditingController();

  bool get isUpdating => widget.note != null;
  bool isGenerating = false;

  void generatingText() async {
    setState(() {
      isGenerating = true;
    });

    final generatedText = await generativeAi.generateNote(
      textPrompt: textController.text,
    );

    setState(() {
      textController.text = generatedText;
      isGenerating = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (isUpdating) {
      titleController.text = widget.note![NotesRepo.columnTitle];
      textController.text = widget.note![NotesRepo.columnText];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text(isUpdating ? "Edit Note" : "New Note"),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left_rounded)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right_rounded)),
          IconButton(onPressed: generatingText, icon: Icon(Icons.auto_awesome)),
        ],
      ),
      body: isGenerating
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.directional(start: 8.0),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Title",
                    ),
                    style: TextStyle(
                      fontFamily: 'Capriola',
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.directional(end: 8.0),
                    child: Text(
                      dateModified,
                      style: TextStyle(fontSize: 12, fontFamily: 'Bitcount'),
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
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    cursorHeight: 16,
                    cursorWidth: 1.0,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
              ],
            ),

      floatingActionButton: IconButton(
        onPressed: () async {
          var thisTitle = titleController.text;
          var thisText = textController.text;

          if (thisTitle.isNotEmpty || thisText.isNotEmpty) {
            final thisDateTime = DateTime.now();
            if (thisTitle.isEmpty) {
              thisTitle = "New Title";
            }
            if (isUpdating) {
              final noteId = widget.note![NotesRepo.columnSno].toInt();
              bool updated = await widget.notesTable.updateNote(
                notesSnO: noteId,
                newTitle: thisTitle,
                newText: thisText,
                newDateTime: thisDateTime,
              );
              if (updated) {
                Navigator.pop(context, true);
              }
            } else {
              bool entered = await widget.notesTable.addNotes(
                myTitle: thisTitle,
                myText: thisText,
                dateModified: thisDateTime,
              );
              if (entered) {
                Navigator.pop(context, true);
              } else {
                Navigator.pop(context);
              }
            }
          }
        },
        icon: Icon(Icons.add),
        iconSize: 35.0,
        color: Colors.brown,
      ),
    );
  }
}
