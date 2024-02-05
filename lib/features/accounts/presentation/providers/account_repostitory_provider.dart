import 'package:riverpod/riverpod.dart';
import 'package:teslo_shop/features/accounts/domain/domain.dart';
import 'package:teslo_shop/features/accounts/infrastructure/datasources/accounts_datasource_implementation.dart';
import 'package:teslo_shop/features/accounts/infrastructure/repositories/accounts_repository_implementation.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_providers.dart';

final accountRepositoryProvider = Provider<AccountsRepository>((ref){

  final accessToken = ref.watch(authProvider).user?.token ?? '';
  
  final accountRepository = AccountRepositoryImplementation(
      AccountsDataSourceImplementation(accessToken: accessToken)
  );

  return accountRepository;
});