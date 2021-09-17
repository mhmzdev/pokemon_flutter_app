part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLogoutRequested extends AppEvent {
  /// Its not working as Expected!
  Future logout() async {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository();
    await authenticationRepository.logOut();
  }
}

class AppUserChanged extends AppEvent {
  @visibleForTesting
  const AppUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
