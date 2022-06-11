import 'package:get/get.dart';

import '../models/signature.dart';
import '../models/transaction.dart';

class HomeController extends GetxController {
  RxList<Transaction> transactions = RxList();
  RxList<Signature> signatures = RxList();
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    signatures.value = await Signature.getSignatures();

    for(var i=0;i<signatures.value.length;i++){
      Transaction transaction = await Transaction.getTransactions(signatures.value[i]);
      // if(transactions.isNotEmpty){
      //   isLoading.value = true;
      // }
      transactions.add(transaction);
      update();
    }

    }
}
