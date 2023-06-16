import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Mockup/mockup_create_controller.dart';
import 'package:flutterpp/App/Views/Global/build_close_button.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_choose_template.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_info.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Create/build_create_mockup_link_project.dart';
import 'package:get/get.dart';

class MockupCreatePage extends GetView<MockupCreateController> {
  const MockupCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MockupCreateController>(
      init: MockupCreateController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: BuildCloseButton(),
              ),
            ],
          ),
          body: GetBuilder<MockupCreateController>(
            init: MockupCreateController(),
            initState: (_) {},
            builder: (_) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Stepper(
                    type: StepperType.vertical,
                    currentStep: controller.currentStep,
                    onStepContinue: () => controller.onStepContinue(),
                    onStepCancel: () => controller.onStepCancel(),
                    // controlsBuilder: ,
                    steps: [
                      Step(
                        title: Text('mockup info'.capitalizeFirst!),
                        content: BuildCreateMockupInfo(
                          onTitleOrDescriptionOrCategory:
                              controller.onTitleOrDescriptionOrCategory,
                          onColorChange: controller.onGradientChange,
                          onSvgChange: controller.onIconChange,
                          activeColors: controller.activeGradient,
                          activeSVG: controller.activeIcon,
                          title: controller.title,
                          description: controller.description,
                          category: controller.category,
                        ),
                      ),
                      Step(
                        title: Row(
                          children: [
                            Text('link to a project'.capitalizeFirst!),
                            const SizedBox(width: 10),
                            if (controller.projects.isEmpty)
                              const Text(
                                'no projects found 😢',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            if (controller.projects.isNotEmpty)
                              Text(
                                'found ${controller.projects.length} projects',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                        content: BuildCreateMockupLinkProject(
                          projects: controller.projects,
                        ),
                      ),
                      Step(
                        title: Text('choose a template'.capitalizeFirst!),
                        content: const BuildCreateMockupChooseTemplate(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
