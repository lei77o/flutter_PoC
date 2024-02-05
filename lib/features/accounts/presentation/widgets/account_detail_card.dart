
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/account.dart';

class AccountDetailCard extends StatelessWidget{

  final Account account;

  const AccountDetailCard({super.key, required this.account});

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAttributeRow('Account Number', account.accountNumber),
              _buildAttributeRow('Status', account.status.code),
              _buildAttributeRow('Policy Number', account.policyNumber),
              _buildAttributeRow('Policy Effective Date', account.policyEffectiveDate.toString()),
              _buildAttributeRow('Payments Made', account.paymentsMade.toString()),
              _buildAttributeRow('Installments', account.installments.toString()),
              _buildAttributeRow('Customer Name', account.customerName),
              _buildAttributeRow('Phone Number', account.phoneNumber),
              _buildAttributeRow('Email', account.email),
              _buildAttributeRow('Address', account.address),
              _buildAttributeRow('Seller Name', account.seller.name),
              _buildAttributeRow('Administrator Name', account.administrator.name),
              _buildAttributeRow('Insurer Name', account.insurer.name),
              _buildAttributeRow('Cancellation Reason', account.cancellationReason.toString()),
              _buildAttributeRow('Cancellation Date', account.cancellationDate.toString()),
              _buildAttributeRow('Calculation Rule Name', account.calculationRuleName),
              _buildAttributeRow('Calculation Rule Type', account.calculationRuleType.value),
              _buildAttributeRow('Oldest Due Date', account.oldestDueDate.toString()),
              _buildAttributeRow('Current Due Date', account.currentDueDate.toString()),
              _buildAttributeRow('Current Schedule', account.currentSchedule.toString()),
              _buildAttributeRow('Pool Name', account.poolName),
              _buildAttributeRow('Payoff Amount', account.payoffAmount.toString()),
            ],
          ),
        ),
    );
  }

    Widget _buildAttributeRow(String label, String value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value ?? 'N/A', // Display 'N/A' if value is null
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16),
        ],
      );
    }
}
