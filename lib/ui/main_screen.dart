import 'package:flutter/material.dart';

import '../components/widgets/main_page_anim_widget.dart';
import '../ui/todos_screen.dart';

class MainScreen extends StatelessWidget {
  void _goNextScreen(BuildContext c, String str) {
    Navigator.push(c, MaterialPageRoute(builder: (_) => TodosScreen(whichTodo: '$str')));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO APP !'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MainPageAnimWidget(width: width, height: height),
          RaisedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'All Todos',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            onPressed: () => _goNextScreen(context, 'All'),
            color: Theme.of(context).primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Done Todos',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                onPressed: () => _goNextScreen(context, 'Done'),
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 30),
              RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    'Undone Todos',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                onPressed: () => _goNextScreen(context, 'Undone'),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
      floatingActionButton: Text('💙 Flutter 💙', style: Theme.of(context).textTheme.headline1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
