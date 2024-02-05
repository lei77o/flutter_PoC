import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  String id;
  String accountNumber;
  CalculationRuleType status;
  String policyNumber;
  DateTime policyEffectiveDate;
  int paymentsMade;
  int installments;
  String customerName;
  String phoneNumber;
  String email;
  String address;
  Administrator seller;
  Administrator administrator;
  Administrator insurer;
  dynamic cancellationReason;
  dynamic cancellationDate;
  String calculationRuleName;
  CalculationRuleType calculationRuleType;
  DateTime oldestDueDate;
  DateTime currentDueDate;
  int currentSchedule;
  String poolName;
  double payoffAmount;

  Account({
    required this.id,
    required this.accountNumber,
    required this.status,
    required this.policyNumber,
    required this.policyEffectiveDate,
    required this.paymentsMade,
    required this.installments,
    required this.customerName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.seller,
    required this.administrator,
    required this.insurer,
    required this.cancellationReason,
    required this.cancellationDate,
    required this.calculationRuleName,
    required this.calculationRuleType,
    required this.oldestDueDate,
    required this.currentDueDate,
    required this.currentSchedule,
    required this.poolName,
    required this.payoffAmount,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    accountNumber: json["accountNumber"],
    status: CalculationRuleType.fromJson(json["status"]),
    policyNumber: json["policyNumber"],
    policyEffectiveDate: DateTime.parse(json["policyEffectiveDate"]),
    paymentsMade: json["paymentsMade"],
    installments: json["installments"],
    customerName: json["customerName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"].toString(),
    address: json["address"],
    seller: Administrator.fromJson(json["seller"]),
    administrator: Administrator.fromJson(json["administrator"]),
    insurer: Administrator.fromJson(json["insurer"]),
    cancellationReason: json["cancellationReason"],
    cancellationDate: json["cancellationDate"],
    calculationRuleName: json["calculationRuleName"],
    calculationRuleType: CalculationRuleType.fromJson(json["calculationRuleType"]),
    oldestDueDate: DateTime.parse(json["oldestDueDate"]),
    currentDueDate: DateTime.parse(json["currentDueDate"]),
    currentSchedule: json["currentSchedule"],
    poolName: json["poolName"],
    payoffAmount: json["payoffAmount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountNumber": accountNumber,
    "status": status.toJson(),
    "policyNumber": policyNumber,
    "policyEffectiveDate": policyEffectiveDate.toIso8601String(),
    "paymentsMade": paymentsMade,
    "installments": installments,
    "customerName": customerName,
    "phoneNumber": phoneNumber,
    "email": email,
    "address": address,
    "seller": seller.toJson(),
    "administrator": administrator.toJson(),
    "insurer": insurer.toJson(),
    "cancellationReason": cancellationReason,
    "cancellationDate": cancellationDate,
    "calculationRuleName": calculationRuleName,
    "calculationRuleType": calculationRuleType.toJson(),
    "oldestDueDate": oldestDueDate.toIso8601String(),
    "currentDueDate": currentDueDate.toIso8601String(),
    "currentSchedule": currentSchedule,
    "poolName": poolName,
    "payoffAmount": payoffAmount,
  };
}

class Administrator {
  String id;
  String name;
  String code;

  Administrator({
    required this.id,
    required this.name,
    required this.code,
  });

  factory Administrator.fromJson(Map<String, dynamic> json) => Administrator(
    id: json["id"],
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
  };
}

class CalculationRuleType {
  String code;
  String value;
  bool disabled;

  CalculationRuleType({
    required this.code,
    required this.value,
    required this.disabled,
  });

  factory CalculationRuleType.fromJson(Map<String, dynamic> json) => CalculationRuleType(
    code: json["code"],
    value: json["value"],
    disabled: json["disabled"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "value": value,
    "disabled": disabled,
  };
}