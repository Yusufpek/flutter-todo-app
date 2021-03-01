import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo_model.dart';
import 'package:flutter_todo_app/services/db_helper.dart';

class NewTodoScreen extends StatefulWidget {
  @override
  _NewTodoScreenState createState() => _NewTodoScreenState();
}

class _NewTodoScreenState extends State<NewTodoScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  DbHelper helper = DbHelper();
  String title, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('New Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Add a new todo !',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: Theme.of(context).textTheme.headline1,
              onChanged: (v) {
                title = v;
              },
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'My new todo !',
              ),
            ),
            SizedBox(height: 30),
            TextField(
              style: Theme.of(context).textTheme.headline1,
              maxLines: 2,
              onChanged: (v) {
                description = v;
              },
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Add a new todo..!',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.done),
              label: Text('Add Todo'),
              onPressed: _checkAndInsert,
            )
          ],
        ),
      ),
    );
  }

  void _checkAndInsert() {
    if (title == null && description == null) {
      _key.currentState.showSnackBar(_snackBar());
    } else {
      var id;
      helper.getAllTodosCount().then((value) => id = value);
      helper.insertTodo(
        Todo(id, title, description, DateTime.now().toString()),
      );
      Navigator.pop(context);
    }
  }

  SnackBar _snackBar() {
    var th = Theme.of(context);
    return SnackBar(
      content: Text(
        "Title or description mustn't be null !",
        style: th.textTheme.subtitle2,
      ),
      backgroundColor: th.primaryColor,
    );
  }
}
