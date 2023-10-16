class NotesModel {
  int? id;
  final String title;
  final int age;
  final String description;
  final String email;

  NotesModel(
      {required this.title,
      required this.age,
      required this.description,
      required this.email});

  NotesModel.withID(
      {this.id,
      required this.title,
      required this.age,
      required this.description,
      required this.email});

//Extracting from map object to class objects===========================
  NotesModel.fromMap(Map<String, dynamic> n)
      : id = n['id'],
        title = n['title'],
        age = n['age'],
        description = n['description'],
        email = n['email'];

//Converting class objects into MAP objects===========================
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'age': age,
      'description': description,
      'email': email
    };
  }
}
