import 'package:firebolt_final/controllers/homeController.dart';
import 'package:firebolt_final/views/widgets/list_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/style.dart';
import '../../constants/texts.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {},
                  child: const Text(
                    heading,
                    style: h1,
                  ),
                ),
              ),
            ),
            Expanded(
            child:Obx((){
              return widget.homeController.isLoading.value?
              const CircularProgressIndicator():
              ListView.builder(
                itemCount: widget.homeController.transactions.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                return customListTile(context,widget.homeController.transactions[index]);
              });
            }))
          ],
        ),
      ),
    );
  }
}
