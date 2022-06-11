import 'package:firebolt_final/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:firebolt_final/constants/api.dart';
import '../../models/transaction.dart';

Widget customListTile(BuildContext context,Transaction transaction) {


  
  return Column(
    children: [
      ListTile(
        onTap: () {
          Clipboard.setData(ClipboardData(text: transaction.transaction.signatures.first)).then((value) =>
              Get.snackbar("TX Id is copied", transaction.transaction.signatures.first,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white));
        },
        leading: Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              color: Colors.white10, shape: BoxShape.circle),
          child: Center(
            child: Icon(
            transaction.transaction.message.accountKeys.first == sourceAddress ?  Icons.call_received : Icons.call_made,
              color: Colors.grey,
            ),
          ),
        ),
        title:  Text(
          transaction.transaction.message.accountKeys.first == sourceAddress ? "Recieved" : "Send",
          style: h1,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 3),child:  Text(
               DateTime.fromMillisecondsSinceEpoch(transaction.blockTime.toInt() * 1000).toString().substring(5,10),
                  style: subHeading,
                ),)
              ),
               Flexible(
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 3),child:  Text(
               DateTime.fromMillisecondsSinceEpoch(transaction.blockTime.toInt() * 1000).toString().substring(10,19),
                  style: subHeading,
                ),)
              ),
              Flexible(
                child: Text(
                  "TXID:${transaction.transaction.signatures.first}",
                  style: subHeading,
                ),
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end, 
          children: [
            Text(
               "${transaction.transaction.message.accountKeys.first == sourceAddress ? "+" : "-"} ${ double.parse(((transaction.meta.preBalances.first-transaction.meta.postBalances.first) / 1000000000).toString()).toStringAsFixed(5)}",
              style:  TextStyle(
    fontSize: 19,
    color:transaction.transaction.message.accountKeys.first == sourceAddress ? Colors.green : Colors.white,
    wordSpacing: 1.2,
    fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.copy,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 20,
          child: const Divider(
            height: 5,
            color: Colors.grey,
          ),
        ),
      ),
    ],
  );
}
