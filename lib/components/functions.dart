import '../models/todo_model.dart';

void toogleTodosDone(Todo todo, var helper, Function function) async {
  todo.isDone = !todo.isDone;
  await helper.updateTodo(todo);
  function();
}
