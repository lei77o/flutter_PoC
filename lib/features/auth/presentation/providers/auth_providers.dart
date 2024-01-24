import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

final AuthProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImplementation();
  return AuthNotifier(
    authRepository: authRepository
  );
});

class AuthNotifier extends StateNotifier<AuthState>{
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}): super(AuthState());

  Future<void> loginUser(String userName, String password) async{
    
    try{
      final user = await authRepository.login(userName, password);
      _setLoggedUser(user);
    }
    catch(e){
      logout('Bad credentials');
    }
    //TODO: here i can add the AWS erros usin ON
    //final user = await authRepository.login(userName, password);
    //state = state.copyWith(user: user, authStatus: AuthStatus.authenticated);
  }

  void checkStatus(){

  }

  void _setLoggedUser( User user ){
    //TODO: i need save token

    state = state.copyWith(
      user: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout(String ? errorMessage) async{
    //TODO: clean token
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus {
  cheking, authenticated, notAuthenticated
}

class AuthState{
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
      this.authStatus = AuthStatus.cheking,
      this.user,
      this.errorMessage= ''
  });
  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage
    );
}