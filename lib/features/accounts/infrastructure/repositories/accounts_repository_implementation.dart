import 'package:teslo_shop/features/accounts/domain/domain.dart';

class AccountRepositoryImplementation extends AccountsRepository{

  final AccountsDataSource dataSource;

  AccountRepositoryImplementation(this.dataSource);

  @override
  Future<Account> getAccountsById(String id) {
    return getAccountsById(id);
  }

  @override
  Future<List<Account>> getAccountsByPage({int limit = 10, int page = 0, offset = 0}) {
    return dataSource.getAccountsByPage(limit: limit, page: page);
  }

  @override
  Future<List<Account>> searchAccountsByTerm(String term) {
    return dataSource.searchAccountsByTerm(term);
  }

  @override
  Future<List<Account>> updateAccount(Map<String, dynamic> accountLike) {
    return dataSource.updateAccount(accountLike);
  }

}