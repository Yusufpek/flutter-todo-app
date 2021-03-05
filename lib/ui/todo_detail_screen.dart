import 'package:flutter/material.dart';
import 'package:flutter_todo_app/components/functions.dart';

import '../models/todo_model.dart';
import '../services/db_helper.dart';

class TodoDetailScreen extends StatefulWidget {
  final Todo todo;
  TodoDetailScreen({Key key, this.todo}) : super(key: key);

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final DbHelper helper = new DbHelper();

  @override
  Widget build(BuildContext context) {
    final String todosSit = widget.todo.isDone ? 'Done !' : 'Undone !';
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Todo's Detail")),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15), color: theme.accentColor),
              child: Text(
                '${widget.todo.title}',
                style: theme.textTheme.headline6,
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: theme.accentColor,
                ),
                child: Text('Description: ${widget.todo.description}',
                    style: theme.textTheme.headline1),
              ),
            ),
          ),
          SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              circularContainer('Date: ${widget.todo.date.substring(0, 10)}', theme),
              SizedBox(height: 20),
              circularContainer('Todo\'s Situation: $todosSit', theme),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton.icon(
            color: theme.errorColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10),
            onPressed: () {
              print('delete');
            },
            icon: Icon(
              Icons.delete_forever,
              color: Colors.white,
            ),
            label: Text(
              'Delete',
              style: theme.textTheme.subtitle2,
            ),
          ),
          SizedBox(width: 20),
          RaisedButton.icon(
            color: theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10),
            onPressed: () => toogleTodosDone(widget.todo, helper, refresh),
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            label: Text(
              widget.todo.isDone ? 'Select Undone' : 'Select Done',
              style: theme.textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  Widget circularContainer(String content, var theme) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(25), color: theme.highlightColor),
        child: Text(
          '$content',
          style: theme.textTheme.subtitle1,
        ),
      ),
    );
  }
}
