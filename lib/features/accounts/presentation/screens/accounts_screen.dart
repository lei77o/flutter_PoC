import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/accounts/presentation/providers/accounts_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

import '../widgets/account_card.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu( scaffoldKey: scaffoldKey ),
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon( Icons.search_rounded)
          )
        ],
      ),
      body: const _AccountsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add Account'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


class _AccountsView extends ConsumerStatefulWidget {
  const _AccountsView();
  @override
  _AccountsViewState createState() => _AccountsViewState();
}

class _AccountsViewState extends ConsumerState{
  
  final ScrollController scrollController = ScrollController();
  
  @override
  void initState(){
    super.initState();
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >= scrollController.position.maxScrollExtent)
        ref.read(accountsProvider.notifier).loadNexPage();
    });
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    final accountsState = ref.watch(accountsProvider);
    return Padding(
     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
     child: ListView.builder(
       controller: scrollController,
       padding: const EdgeInsets.all(10),
       itemCount: accountsState.accounts.length,
        itemBuilder: (context, index) {
        final account = accountsState.accounts[index];
          return GestureDetector(
            onTap: ()=> context.push('/account/${account.id}'),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: AccountCard(account: account)
            )
          );
        }
      )
    );
  }
}