import 'dart:convert';

import 'package:firebolt_final/constants/api.dart';
import 'package:firebolt_final/models/signature.dart';
import 'package:firebolt_final/utils/client.dart';

class Meta{
  String? err;
  int fee;
  List<String> innerInstructions;
  List<String> logMessages;
  List<int> postBalances;
  List<Map<String,dynamic>> postTokenBalances;
  List<int> preBalances;
  List<Map<String,dynamic>> preTokenBalances;
  List<String> rewards;

  Meta({
    required this.err,
    required this.fee,
    required this.innerInstructions,
    required this.logMessages,
    required this.postBalances,
    required this.postTokenBalances,
    required this.preBalances,
    required this.preTokenBalances,
    required this.rewards,
  });
  factory Meta.fromJSON(Map<String,dynamic> json){
    return Meta(
      err: json['err'],
      fee: json['fee'],
      innerInstructions: List<String>.from(json['innerInstructions']),
      logMessages: List<String>.from(json['logMessages']),
      postBalances: List<int>.from(json['postBalances']),
      postTokenBalances: List<Map<String,dynamic>>.from(json['postTokenBalances']),
      preBalances: List<int>.from(json['preBalances']),
      preTokenBalances:List<Map<String,dynamic>>.from(json['preTokenBalances']),
      rewards: List<String>.from(json['rewards'])
    );
  }
}

class TransactionData{
  Message message;
  List<String> signatures;

  TransactionData({
    required this.message,
    required this.signatures
  });

  factory TransactionData.fromJSON(Map<String,dynamic> json){
    return TransactionData(message: Message.fromJSON(json['message']), signatures: List<String>.from(json['signatures']));
  }
}

class Message{
  List<String> accountKeys;
  Map<String,dynamic> header;
  List<Map<String,dynamic>> instructions;
  String recentBlockhash;

  Message({
    required this.accountKeys,
    required this.header,
    required this.instructions,
    required this.recentBlockhash
  });

  factory Message.fromJSON(Map<String,dynamic> json){
    return Message(
      accountKeys: List<String>.from(json['accountKeys']),
      header: json['header'],
      instructions: List<Map<String,dynamic>>.from(json['instructions']),
      recentBlockhash: json['recentBlockhash'],
    );
  }
}
class Transaction {
  double blockTime;
  Meta meta;
  double slot;
  TransactionData transaction;

  Transaction({
    required this.blockTime,
    required this.meta,
    required this.slot,
    required this.transaction,
       });

// Converting Transaction Model from Json

  factory Transaction.fromJSON(Map<String, dynamic> json) {
    return Transaction(
      blockTime: json['blockTime'].toDouble(),
      meta: Meta.fromJSON(json['meta']),
      slot: json['slot'].toDouble(),
      transaction: TransactionData.fromJSON(json['transaction'])
    );
  }

  static Future<Transaction> getTransactions(Signature signatures) async {
      final String mappedBody = jsonEncode({
        "jsonrpc": "2.0",
        "id": 1,
        "method": "getTransaction",
        "params": [
          signatures.signature,
          {"limit": 10}
        ]
      });
    final Map<String, dynamic> response = await 
        FireBoltClient.post(baseURL, mappedBody);

    return Transaction.fromJSON(response['result']);
    
  }
}
