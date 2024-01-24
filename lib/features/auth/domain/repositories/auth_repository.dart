import '../entities/user.dart';

abstract class AuthRepository {

  Future<User> login( String userName, String password );
  Future<User> register( String email, String password, String fullName );
  Future<User> checkAuthStatus( String token );

}