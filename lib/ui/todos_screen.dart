import 'package:flutter/material.dart';
import 'package:flutter_todo_app/ui/new_todo_screen.dart';

import '../components/widgets/todo_list_widget.dart';
import '../models/todo_model.dart';
import '../services/db_helper.dart';

class TodosScreen extends StatelessWidget {
  final String whichTodo;

  TodosScreen({Key key, this.whichTodo}) : super(key: key);

  final DbHelper helper = DbHelper();
  Future<List<Todo>> _getTodos(String s) async {
    if (s == 'Undone') {
      return await helper.getUnDoneTodos();
    } else if (s == 'Done') {
      return await helper.getDoneTodos();
    } else {
      return helper.getAllTodos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$whichTodo Todos'),
      ),
      body: FutureBuilder(
        future: _getTodos(whichTodo),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print((snapshot.data as List).length);
            if ((snapshot.data as List).length > 0)
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: (snapshot.data as List).length,
                      itemBuilder: (_, i) => TodoListWidget(todo: snapshot.data[i]),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NewTodoScreen())),
      ),
    );
  }
}
