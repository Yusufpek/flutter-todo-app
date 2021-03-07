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
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: theme.accentColor,
                ),
                child: Column(
                  children: [
                    Text('${widget.todo.title.toUpperCase()}', style: theme.textTheme.headline6),
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      thickness: 3,
                      color: theme.primaryColor,
                    ),
                    Text('${widget.todo.description}', style: theme.textTheme.headline1),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              circularContainer(title: 'Date', content: '${widget.todo.date.substring(0, 10)}'),
              SizedBox(height: 20),
              circularContainer(title: 'Todo\'s Situation', content: '$todosSit'),
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
            onPressed: _showDialog,
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

  Widget circularContainer({String title, String content}) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: theme.accentColor,
          border: Border.all(width: 2, color: theme.primaryColor),
        ),
        child: RichText(
          text: TextSpan(
            text: '$title: ',
            style: theme.textTheme.subtitle2,
            children: <TextSpan>[
              TextSpan(text: '$content', style: theme.textTheme.subtitle1),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    TextStyle _style = Theme.of(context).textTheme.headline1;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete to-do ',
            style: _style,
          ),
          content: Text(
            "Are you sure to delete '${widget.todo.title}' ?",
            style: _style,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes !', style: Theme.of(context).textTheme.subtitle1),
              onPressed: () async {
                await helper.deleteTodo(widget.todo.id);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'No !',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
