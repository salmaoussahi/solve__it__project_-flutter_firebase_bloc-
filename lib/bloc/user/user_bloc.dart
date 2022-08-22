import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterfirebase/bloc/user/user_event.dart';
import 'package:flutterfirebase/bloc/user/user_state.dart';
import 'package:flutterfirebase/repository/user.repository.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
// Lorsque l'utilisateur appuie sur le bouton de connexion,
// nous envoyons l'événement SignInRequested à AuthBloc pour
//le gérer et émettre l'état authentifié si l'utilisateur est authentifié
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
// Lorsque l'utilisateur appuie sur le bouton d'inscription, nous enverrons l'événement SignUpRequest au AuthBloc pour le gérer et émettre l'état authentifié si l'utilisateur est authentifié
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            email: event.email,
            password: event.password,
            f_name: event.f_name,
            l_name: event.l_name);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // Lorsque l'utilisateur appuie sur le bouton de connexion Google, nous envoyons l'événement GoogleSignInRequest à AuthBloc pour le gérer et émettre l'état authentifié si l'utilisateur est authentifié
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // Lorsque l'utilisateur appuie sur le bouton de déconnexion, nous envoyons l'événement SignOutRequested à AuthBloc pour le gérer et émettre l'état non authentifié
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
    // Lorsque l'utilisateur se dirige vers son profil,
// nous envoyons l'événement UserProbfilRequested à authBloc pour le gérer
    on<UserProfilRequested>((event, emit) async {
      emit(LodingUserProfil());
      try {
        emit(LoadedUserProfil(profil: await authRepository.userProfile()));
      } catch (e) {
        emit(ErrorUserProfil(errormessage: e.toString()));
      }
    });

    // Lorsque l'utilisateur se dirige vers son profil,
// nous envoyons l'événement UserProbfilRequested à authBloc pour le gérer
    on<UserProfilUpdateRequested>((event, emit) async {
      emit(LodingUserProfilUpdate());
      try {
        await authRepository.updateUser(event.nom, event.prenom);
        emit(LoadedUserProfilUpdate());
      } catch (e) {
        emit(ErrorUserProfilUpdate(errormessage: e.toString()));
      }
    });
  }
}
