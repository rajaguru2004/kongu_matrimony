import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kongu_matrimony/app/utils/common_text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CommonText('HomeView'), centerTitle: true),
      body: Center(
        child: CommonText(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
