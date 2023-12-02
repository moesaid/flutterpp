import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_single_controller.dart';
import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Global/build_appbar.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_sidebar.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/build_device_card.dart';
import 'package:get/get.dart';

class MockupSinglePage extends GetView<MockupSingleController> {
  const MockupSinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupSingleController>(
      init: MockupSingleController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: BuildAppBar(
            title: 'Mockup',
            onBack: () => print('onBack'),
          ),
          body: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black87,
                    child: const Center(
                      child: BuildDeviceCard(
                        config: TemplateLayoutEnum.titleUp,
                      ),
                    ),
                  ),
                ),
                const BuildCreateMockupSidebar(
                  isScreenshotSelected: true,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
