import '../entities/account.dart';

abstract class AccountsDataSource{
  Future<List<Account>> getAccountsByPage({
    int limit = 10, int page = 0
  });
  Future<Account> getAccountsById(String id);
  Future<List<Account>> searchAccountsByTerm(String term);
  Future<List<Account>> updateAccount(Map<String, dynamic> accountLike);
}