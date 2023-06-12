class Beneficiary {
  final String? accountHolderName;
  final String? accountNumber;
  final String? bankName;
  final String? swiftCode;
  final String? routingNumber;

  Beneficiary({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.swiftCode,
    this.routingNumber,
  });

  Beneficiary.fromJson(Map<String, dynamic> json)
      : accountHolderName = json['accountHolderName'] as String?,
        accountNumber = json['accountNumber'] as String?,
        bankName = json['bankName'] as String?,
        swiftCode = json['swiftCode'] as String?,
        routingNumber = json['routingNumber'] as String?;

  Map<String, dynamic> toJson() => {
        'accountHolderName': accountHolderName,
        'accountNumber': accountNumber,
        'bankName': bankName,
        'swiftCode': swiftCode,
        'routingNumber': routingNumber
      };
}
