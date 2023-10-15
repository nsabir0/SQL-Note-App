import 'package:flutter/material.dart';
import 'package:notes_sql/Database/database_helper.dart';
import 'package:notes_sql/Model/notes_model.dart';

class MyNotes extends StatefulWidget {
  const MyNotes({super.key});

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  DatabaseHelper? DBhelper;
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    super.initState();
    DBhelper = DatabaseHelper();
    loadData();
  }

  loadData() async {
    notesList = DBhelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NOTES SQL'), centerTitle: true),
      body: Column(
        children: [
          const Text('My Notes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(snapshot.data![index].title.toString()),
                          subtitle: Text(
                              snapshot.data![index].description.toString()),
                          trailing: Text(snapshot.data![index].age.toString()),
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DBhelper!
              .insert(NotesModel(
                  title: 'title',
                  age: 25,
                  description: 'description',
                  email: 'abir@gmail.com'))
              .then((value) => {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('DATA SAVED'),
                    )),
                    setState(() {
                      notesList = DBhelper!.getNotesList();
                    })
                  });
        },
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}
