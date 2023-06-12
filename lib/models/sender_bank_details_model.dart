class SenderBankDetails {
  final String? bankName;
  final String? accountNumber;
  final String? ifscCode;

  SenderBankDetails({
    this.bankName,
    this.accountNumber,
    this.ifscCode,
  });

  SenderBankDetails.fromJson(Map<String, dynamic> json)
      : bankName = json['bankName'] as String?,
        accountNumber = json['accountNumber'] as String?,
        ifscCode = json['ifscCode'] as String?;

  Map<String, dynamic> toJson() => {
        'bankName': bankName,
        'accountNumber': accountNumber,
        'ifscCode': ifscCode
      };
}