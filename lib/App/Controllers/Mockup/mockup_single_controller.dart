import 'package:flutter/material.dart';
import 'package:flutterpp/App/Models/gradient_model.dart';
import 'package:flutterpp/App/Models/mockup_model.dart';
import 'package:flutterpp/App/Models/template_config_model.dart';
import 'package:flutterpp/App/Services/Mockups/mockup_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/Helpers/colors_helper.dart';
import 'package:get/get.dart';

class MockupSingleController extends GetxController {
  MockupServices mockupServices = MockupServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _mockup = MockupModel().obs;
  MockupModel get mockup => _mockup.value;

  final _seletedItem = TemplateConfigModel().obs;
  TemplateConfigModel get seletedItem => _seletedItem.value;

  @override
  void onInit() {
    _getMockup();

    super.onInit();
  }

  // get mockup
  void _getMockup() {
    _mockup.value = Get.arguments as MockupModel;
    _isLoading.value = false;
    update();
  }

  // update mockup
  Future<void> updateMockup() async {
    await Get.showOverlay(
      asyncFunction: () async {
        await mockupServices.updateMockup(mockup: _mockup.value);
      },
      loadingWidget: const BuildOverlay(),
    );
  }

  // update selected item
  void updateSelectedItem(TemplateConfigModel item) {
    if (item.id == _seletedItem.value.id) return;

    _seletedItem.value = item;
    update();
  }

  // update background
  void updateBackground({
    Color? color,
    String? image,
    GradientModel? gradient,
  }) {
    _seletedItem.value = _seletedItem.value.copyWith(
      backgroundColor: color,
      backgroundImage: image,
      backgroundGradient: gradient == null ||
              gradient.colors == null ||
              gradient.colors!.isEmpty
          ? null
          : [
              ColorHelper.hexToColor(gradient.colors!.first),
              ColorHelper.hexToColor(gradient.colors!.last),
            ],
      gradientAngle: gradient?.angle,
    );

    // update mockup jsonData
    _updateMockupData();
  }

  // update icon toggle
  onIconToggle(bool value) {
    _seletedItem.value = _seletedItem.value.copyWith(
      showLogo: value,
    );

    // update mockup jsonData
    _updateMockupData();
  }

  // update mockup data
  _updateMockupData() {
    List<TemplateConfigModel> jsonData = mockup.jsonData!;
    int index = jsonData.indexWhere((el) => el.id == _seletedItem.value.id);
    jsonData[index] = _seletedItem.value;
    _mockup.value = _mockup.value.copyWith(jsonData: jsonData);
  }
}
