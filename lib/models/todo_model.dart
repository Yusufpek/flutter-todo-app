class Todo {
  int id;
  String title;
  String description;
  String date;
  bool isDone;

  Todo(this.id, this.title, this.description, this.date, {this.isDone: false});
  //Todo.withId(this.id, this.title, this.description, this.date,
  //  {this.isDone: false});

/*
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
*/

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      data['id'],
      data['title'],
      data['description'],
      data['date'],
      isDone: data['isDone'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> _map = {
      'title': this.title,
      'description': this.description,
      'isDone': this.isDone ? 1 : 0,
      'date': this.date,
    };
    if (this.id != null) {
      _map['id'] = this.id;
    }
    return _map;
  }
}
