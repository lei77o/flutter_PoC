import 'package:teslo_shop/features/auth/domain/domain.dart';
import '../infrastructure.dart';

class AuthRepositoryImplementation extends AuthRepository{

  final AuthDataSource dataSource;

  AuthRepositoryImplementation({AuthDataSource? dataSource}) : dataSource = dataSource ?? AuthDataSourceImplementation();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String userName, String password) {
    return dataSource.login(userName, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return dataSource.register(email, password, fullName);
  }

}