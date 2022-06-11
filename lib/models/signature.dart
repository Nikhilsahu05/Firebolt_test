import 'dart:convert';

import 'package:firebolt_final/constants/api.dart';
import 'package:flutter/foundation.dart';

import '../utils/client.dart';

class Signature {
  String confirmationStatus;
  double blockTime;
  String? err;
  String? memo;
  String signature;
  double slot;

  Signature(
      {required this.confirmationStatus,
      required this.blockTime,
      required this.err,
      required this.memo,
      required this.slot,
      required this.signature});

  // Converting Transaction Model to MAP

  Map<String, dynamic> toMap() {
    return {
      "confirmationStatus": confirmationStatus,
      "blockTime": blockTime,
      "err": err,
      "memo": memo,
      "slot": slot,
      "signature": signature,
    };
  }

// Converting Transaction Model from Json

  factory Signature.fromJSON(Map<String, dynamic> json) {
    return Signature(
      confirmationStatus: json["confirmationStatus"],
      err: json["err"],
      memo: json["memo"],
      slot: json["slot"].toDouble(),
      signature: json["signature"],
      blockTime: json["blockTime"].toDouble(),
    );
  }

  static Future<List<Signature>> getSignatures() async {
    List<Signature> signatures = [];

    final String mappedBody = jsonEncode({
      "jsonrpc": "2.0",
      "id": 1,
      "method": "getSignaturesForAddress",
      "params": [
        sourceAddress,
        {"limit": 10}
      ]
    });
    final Map<String, dynamic> response =
        await FireBoltClient.post(baseURL, mappedBody);

    // if (kDebugMode) {
    //   print(response);
    // }
    (response['result'] as List).forEach((data){
      signatures.add(Signature.fromJSON(data));
    });

    return signatures;
  }
}
