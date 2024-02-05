import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/accounts/domain/domain.dart';

class AccountScreen extends ConsumerStatefulWidget{

  final String accountId;

  const AccountScreen({super.key, required this.accountId});

  @override
  AccountScreenState createState()=> AccountScreenState();

}

class AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context){
       return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: Center(
        child: Text(widget.accountId),
      ),
    );
  }
}