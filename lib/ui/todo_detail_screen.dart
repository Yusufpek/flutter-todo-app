import 'package:flutter/material.dart';
import 'package:flutter_todo_app/services/db_helper.dart';

class TodoDetailScreen extends StatelessWidget {
  final int id;
  TodoDetailScreen({Key key, this.id}) : super(key: key);

  final DbHelper helper = new DbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo's Detail")),
      body: FutureBuilder(
        future: helper.getTodo(id),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView();
          else if (snapshot.hasError)
            return Center(child: Text('Ups sorry, i have a problem :( '));
          else
            return Center(
                child: CircularProgressIndicator(backgroundColor: Theme.of(context).accentColor));
        },
      ),
    );
  }
}
