import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'groupe_event.dart';
part 'groupe_state.dart';

class GroupeBloc extends Bloc<GroupeEvent, GroupeState> {
  GroupeBloc() : super(GroupeInitial()) {
    on<GroupeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
