import 'package:flutter/material.dart';
import 'package:flutter_todo_app/ui/new_todo_screen.dart';

import '../components/widgets/todo_list_widget.dart';
import '../models/todo_model.dart';
import '../services/db_helper.dart';

class TodosScreen extends StatefulWidget {
  final String whichTodo;
  TodosScreen({Key key, this.whichTodo}) : super(key: key);

  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  GlobalKey scaffoldKey;

  final DbHelper helper = DbHelper();
  List todos;
  bool isTodosOk = false;
  Future<void> _getTodos(String s) async {
    if (s == 'Undone') {
      todos = await helper.getUnDoneTodos();
    } else if (s == 'Done') {
      todos = await helper.getDoneTodos();
    } else {
      todos = await helper.getAllTodos();
    }
    isTodosOk = true;
    setState(() {});
  }

  @override
  void initState() {
    _getTodos(widget.whichTodo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('${widget.whichTodo} Todos'),
      ),
      body: isTodosOk
          ? todos.length > 0
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (_, i) => TodoListWidget(
                          todo: todos[i],
                          scaffoldKey: scaffoldKey,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(child: Text('You don\'t have any task !'))
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
      /*
      FutureBuilder(
        future: _getTodos(widget.whichTodo),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print((snapshot.data as List).length);
            if ((snapshot.data as List).length > 0)
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: (snapshot.data as List).length,
                      itemBuilder: (_, i) => TodoListWidget(
                        todo: snapshot.data[i],
                        scaffoldKey: scaffoldKey,
                      ),
                    ),
                  ),
                ],
              );
            else
              return Center(child: Text('You don\'t have any task !'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Ups sorry, i have a problem :( '));
          } else {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).accentColor,
            ));
          }
        },
      ),*/
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NewTodoScreen())),
      ),
    );
  }
}
//https://google.qualtrics.com/jfe/form/SV_eKYon5R5FfrS38G?Source=VSCode&ClientID=22a16133-4c7c-42ad-8280-0451e47b32aa
