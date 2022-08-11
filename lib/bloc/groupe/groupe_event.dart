part of 'groupe_bloc.dart';

abstract class GroupeEvent extends Equatable {
  const GroupeEvent();

  @override
  List<Object> get props => [];
}

class AddgroupRequest extends GroupeEvent {
  final String libelle;

  AddgroupRequest(this.libelle);
}
