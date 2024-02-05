
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/account.dart';

class AccountCard extends StatelessWidget{

  final Account account;

  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context){
      return Card(
        elevation: 1, // Adjust elevation as needed
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
              children:[
                ListTile(
                  title: Text(account.accountNumber, textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,// Change the color here
                    ),
                  ),
                  leading: const Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  trailing: Container(
                    // Add your validation logic here
                    child: account.status.code == "cancelled" ? Icon(Icons.cancel) : Icon(Icons.check_circle),
                    // Adjust the size of the icon or image as needed
                    width: 24,
                    height: 24,),
                ),
                Text(account.policyNumber, style: const TextStyle(
                  fontSize: 20,// Change the color here
                )),
                Text( account.seller.name,style: const TextStyle(
                  fontSize: 20,// Change the color here
                )),
                Text( account.policyNumber,style: const TextStyle(
                  fontSize: 20,// Change the color here
                )),
                Text( account.administrator.name,style: const TextStyle(
                  fontSize: 20,// Change the color here
                )),
              ]
          ),
        )

      );
  }
}