import 'package:equatable/equatable.dart';
import 'package:do_it/src/models/to_do_category_model.dart';

class ToDoCategoryEvent extends Equatable {
  const ToDoCategoryEvent();

  @override
  List<Object> get props => [];
}

class ToDoCategoryLoadEvent extends ToDoCategoryEvent {}

class AddToDoCategoryEvent extends ToDoCategoryEvent {
  final ToDoCategory toDoCategory;
  AddToDoCategoryEvent(this.toDoCategory);
}

class ShowColorPickerEvent extends ToDoCategoryEvent {}
