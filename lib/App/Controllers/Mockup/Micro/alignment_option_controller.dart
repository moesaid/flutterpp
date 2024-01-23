import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlignmentOptionController extends GetxController {
  final _alignment = MainAxisAlignment.center.obs;
  MainAxisAlignment get alignment => _alignment.value;

  setInitialAlignment(MainAxisAlignment alignment) {
    _alignment.value = alignment;
  }

  void setAlignment({
    required MainAxisAlignment alignment,
    Function(MainAxisAlignment)? onToggle,
  }) {
    _alignment.value = alignment;
    update();

    onToggle?.call(alignment);
  }
}
