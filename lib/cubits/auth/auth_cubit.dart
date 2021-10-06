import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // auth check
  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      String _userId = prefs.getString('userId');
      emit(AuthLoginCheck(_userId == null ? null : _userId));
    } catch (e) {
      emit(AuthInitial());
    }
  }

  // login
  Future login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(AuthLoginLoading());
    try {
      User user = (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;

      if (user != null) {
        // prefs.setString('userId', user.uid);
        emit(AuthLoginSuccess(user));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthLoginError(e.message));
    }
  }

  // signUp
  Future signUp(String name, String email, String password) async {
    emit(AuthSignUpLoading());
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        user.updateDisplayName(name);
        emit(AuthSignUpSuccess());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthSignUpError(e.message));
    }
  }

  // logout
  Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    prefs.remove('userId');
    emit(AuthLogOut());
  }
}
