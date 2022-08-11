import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterfirebase/repository/groupe.repository.dart';

part 'groupe_event.dart';
part 'groupe_state.dart';

class GroupeBloc extends Bloc<GroupeEvent, GroupeState> {
  final Grouprepository grouprepository;
  GroupeBloc({required this.grouprepository}) : super(GroupeInitial()) {
    on<GroupeEvent>((event, emit) {
      // Lorsque l'utilisateur appuie sur le bouton d'ajout,
      // nous envoyons l'événement AddgroupRequest à 
      //GroupeBloc pour le gérer 

       on<AddgroupRequest>((event, emit) async {
      emit(Loading());
      try {
        await grouprepository.CreateGroup(
            libelle: event.libelle);
        emit(GroupeAdded());
      } catch (e) {
        emit(GroupError(e.toString()));
        emit(GroupeInitial());
      }
    });

    });
  }
}
