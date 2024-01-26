import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_implementation.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

final authProvider  = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImplementation();
  final keyValueStorageService = KeyValueStorageServiceImplementation();


  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
    );
  });

class AuthNotifier extends StateNotifier<AuthState>{
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier({required this.authRepository, required this.keyValueStorageService}): super(AuthState());

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

  void checkStatus() async{
    final token = await keyValueStorageService.getValue<String>('token');
    if (token == null) return logout();
    try{
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    }
    catch(e){

    }
  }

  void _setLoggedUser( User user ) async{
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      errorMessage: '',
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout([String? errorMessage]) async{
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus {
  checking, authenticated, notAuthenticated
}

class AuthState{
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
      this.authStatus = AuthStatus.checking,
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