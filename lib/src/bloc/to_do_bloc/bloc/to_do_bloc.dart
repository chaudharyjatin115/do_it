import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:do_it/repositoires/todo_repository.dart';
import 'package:do_it/src/bloc/to_do_bloc/bloc/to_do_event.dart';
import 'package:do_it/src/bloc/to_do_bloc/bloc/to_do_state.dart';
import 'package:do_it/src/models/to_do_category_model.dart';

class ToDoBloc extends Bloc<ToDoCategoryEvent, ToDoState> {
  final ToDoRepository todorep;
  final User user;
  ToDoBloc(this.todorep, this.user) : super(LoadingToDoState()) {
    on((event, emit) async {
      final User user = FirebaseAuth.instance.currentUser!;
      List<Iterable<ToDoCategory>> todoslist =
          await todorep.retrieveUserData(user);
      emit(LoadedToDoState(todos: todoslist));
    });

    on<AddToDoCategoryEvent>((event, emit) {
      if (event.toDoCategory == null) {
        ToDoRepository().addToDoCategory(event.toDoCategory, user);
        emit(ToDoCategoryAddedState());
      }
    });

    on<ShowColorPickerEvent>((event, emit) => ShowColorPickerState());
  }

  // void _onWatchToDoCategoryEvent(
  //     ToDoCategoryLoaded event, Emitter<ToDoState> emit) async {
  //   final User user = FirebaseAuth.instance.currentUser!;
  //   await emit.forEach(ToDoRepository().retrieveToDos(user),
  //       onData: (List<ToDoCategory> todos) {
  //     if (todos == null) {
  //       return LoadedToDoState(todos: []);
  //     } else {
  //       return LoadedToDoState(todos: todos);
  //     }
  //   });
  // }
}
