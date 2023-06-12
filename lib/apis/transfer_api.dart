import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tua/models/transfer_model.dart';

import '../constants/api_constants.dart';

class TransferAPI {
  static var dio = Dio();

  Future<Transfer?> createTransfer(Transfer transfer) async {
    // Response Headers
    dio.options.headers['Content-Type'] = 'application/json;charset=UTF-8';
    dio.options.headers['Charset'] = 'utf-8';

    try {
      String transferEncoded = jsonEncode(transfer.toJson());
      // print(transferEncoded);
      final Response response = await dio.post(
          '${APIConstants.baseURL}${APIConstants.createTransferRoute}',
          data: transferEncoded);
      if (response.statusCode == 200) {
        // print(response.data);
        final json = response.data;
        final transfer = Transfer.fromJson(json);
        return transfer;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
