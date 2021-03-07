import 'package:flutter/material.dart';

import '../../components/colors.dart';
import '../../models/todo_model.dart';
import '../../services/db_helper.dart';
import '../../ui/todo_detail_screen.dart';
import '../functions.dart';

class TodoListWidget extends StatefulWidget {
  final Todo todo;
  final GlobalKey scaffoldKey;
  const TodoListWidget({Key key, this.todo, this.scaffoldKey}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState(todo);
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final Todo todo;
  _TodoListWidgetState(this.todo);

  DbHelper helper = DbHelper();
  bool widgetDetail = true;

  @override
  Widget build(BuildContext context) {
    IconData icon = todo.isDone ? Icons.done : Icons.topic_outlined;
    var _style = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(8),
      child: widgetDetail
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _style.accentColor,
                  child: Icon(icon, color: todoBlack),
                ),
                title: Text(
                  '${widget.todo.title}',
                  style: _style.textTheme.headline1,
                ),
                subtitle: Text(
                  '${widget.todo.description}',
                  maxLines: 1,
                  style: _style.textTheme.subtitle1,
                ),
                isThreeLine: false,
                trailing: Icon(Icons.more_vert, color: todoBlack),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TodoDetailScreen(todo: todo))),
                onLongPress: _toogleWidgetSit,
              ),
            )
          : InkWell(
              child: Container(
                width: double.maxFinite - 16,
                height: MediaQuery.of(context).size.height * 0.09,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: _style.primaryColorLight,
                        child: IconButton(
                          onPressed: _toogleWidgetSit,
                          color: _style.primaryColorDark,
                          icon: Icon(Icons.chevron_left),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: _style.primaryColor,
                        child: IconButton(
                          onPressed: () => toogleTodosDone(todo, helper, _toogleWidgetSit),
                          color: _style.accentColor,
                          icon: Icon(Icons.done),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: _style.accentColor,
                        child: IconButton(
                          onPressed: _showDialog,
                          color: errorRed,
                          icon: Icon(Icons.delete_forever),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onLongPress: _toogleWidgetSit),
    );
  }

  void _toogleWidgetSit() async {
    widgetDetail = !widgetDetail;
    setState(() {});
  }

  Future<void> _showDialog() async {
    TextStyle _style = Theme.of(context).textTheme.headline1;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Deleting ${todo.title}.',
            style: _style,
          ),
          content: Text(
            'Are you sure to delete ${todo.title} ?',
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
                _toogleWidgetSit();
              },
            ),
          ],
        );
      },
    );
  }
}
