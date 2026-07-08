import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalLoaderController extends GetxController {
  final isLoading = false.obs;
  int _requestCount = 0;

  void show() {
    _requestCount++;
    _safeUpdate(true);
  }

  void hide() {
    _requestCount--;
    if (_requestCount <= 0) {
      _requestCount = 0;
      _safeUpdate(false);
    }
  }

  void _safeUpdate(bool value) {
    if (Get.isRegistered<GlobalLoaderController>()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = value;
      });
    }
  }
}
