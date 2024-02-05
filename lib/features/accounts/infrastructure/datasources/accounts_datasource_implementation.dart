import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/accounts/domain/datasoruces/accounts_datasource.dart';
import 'package:teslo_shop/features/accounts/domain/entities/account.dart';

class AccountsDataSourceImplementation extends AccountsDataSource{
  late final Dio dio;
  final String accessToken;

  AccountsDataSourceImplementation({
    required this.accessToken
    }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers:{
        'Authorization': 'Bearer $accessToken'
      }
    )
  );

  @override
  Future<Account> getAccountsById(String id) {

    throw UnimplementedError();
  }

  @override
  Future<List<Account>> getAccountsByPage({int limit = 10, int page = 0}) async {
    var data = json.encode({
      "accountNumber": "22"
    });
    final response = await dio.post<dynamic>('accountModule/accounts/search?skip=0&limit=5&page=0', data: data);

    Map<String, dynamic> jsonData = json.decode(response.data as String);

    // Access the 'data' element
    List<dynamic> aux = jsonData['data'];

    final List<Account> accounts = [];
    for (final account in aux ?? []){
        accounts.add(Account.fromJson(account));
        print(account);
    }
    return accounts;

  }

  @override
  Future<List<Account>> searchAccountsByTerm(String term) {
    // TODO: implement searchAccountsByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Account>> updateAccount(Map<String, dynamic> accountLike) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }
  
}