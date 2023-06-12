import 'package:tua/models/beneficiary_model.dart';
import 'package:tua/models/sender_model.dart';
import 'package:tua/models/sender_bank_details_model.dart';

class Transfer {
  String? transferId;
  Sender? sender;
  SenderBankDetails? senderBankDetails;
  Beneficiary? beneficiary;
  int amount;

  Transfer({
    this.sender,
    this.senderBankDetails,
    this.beneficiary,
    this.amount = 0,
  });

  Transfer.fromJson(Map<String, dynamic> json)
      : sender = (json['sender'] as Map<String, dynamic>?) != null
            ? Sender.fromJson(json['sender'] as Map<String, dynamic>)
            : null,
        senderBankDetails =
            (json['senderBankDetails'] as Map<String, dynamic>?) != null
                ? SenderBankDetails.fromJson(
                    json['senderBankDetails'] as Map<String, dynamic>)
                : null,
        beneficiary = (json['beneficiary'] as Map<String, dynamic>?) != null
            ? Beneficiary.fromJson(json['beneficiary'] as Map<String, dynamic>)
            : null,
        amount = json['amount'] as int,
        transferId = json['_id'];

  Map<String, dynamic> toJson() => {
        'sender': sender?.toJson(),
        'senderBankDetails': senderBankDetails?.toJson(),
        'beneficiary': beneficiary?.toJson(),
        'amount': amount
      };

  updateSender(Sender newSender) {
    sender = newSender;
  }

  updateSenderBankDetails(SenderBankDetails newSenderBankDetails) {
    senderBankDetails = newSenderBankDetails;
  }

  updateBeneficiary(Beneficiary newBeneficiary) {
    beneficiary = newBeneficiary;
  }

  updateAmount(int newAmount) {
    amount = newAmount;
  }

  updatetransferId(String id) {
    transferId = id;
  }
}
