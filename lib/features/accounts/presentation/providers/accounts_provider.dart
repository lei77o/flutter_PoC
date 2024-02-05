import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/account.dart';
import '../../domain/repositories/accounts_repository.dart';
import 'account_repostitory_provider.dart';

final accountsProvider = StateNotifierProvider<AccountStateNotifier, AccountsState>((ref){
  
  final accountsRepository = ref.watch(accountRepositoryProvider);
  
  return AccountStateNotifier(accountRepository: accountsRepository);

});

class AccountStateNotifier extends StateNotifier<AccountsState>{

  final AccountsRepository accountRepository;

  AccountStateNotifier({
    required this.accountRepository
    }): super(AccountsState()){
    loadNexPage();
  }

  Future loadNexPage() async {
    if(state.isLoading || state.isLastPage ) return;

    state = state.copyWith(isLoading: true);

    final accounts = await accountRepository.getAccountsByPage(
      limit: state.limit,
      offset: state.offset
    );

    if (accounts.isEmpty){
      state = state.copyWith(
        isLoading: false,
        isLastPage: true
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      isLastPage: false,
      offset: state.offset + 10,
      accounts: [... state.accounts, ...accounts]
    );
  }

}

class AccountsState{
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Account> accounts;
  AccountsState({this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.accounts = const []
  });
  AccountsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Account>? accounts,
  })=> AccountsState(
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      isLoading: isLoading ?? this.isLoading,
      accounts: accounts ?? this.accounts
  );

}