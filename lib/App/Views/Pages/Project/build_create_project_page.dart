import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_icon_and_gradients.dart';
import 'package:flutterpp/Config/app_gradients.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class BuildCreateProjectPage extends StatelessWidget {
  final List<String> svgs;
  final String activeSVG;
  final List<Color> activeColors;
  final Function(List<Color>) onColorChange;
  final Function(String) onSvgChange;
  final Function(Map) createTeam;
  final List<List<Color>> colors;
  const BuildCreateProjectPage({
    Key? key,
    required this.onColorChange,
    required this.colors,
    required this.activeSVG,
    required this.activeColors,
    required this.svgs,
    required this.onSvgChange,
    required this.createTeam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    BuildIconAndGradients(
                      onColorChange: (val) => onColorChange.call(val),
                      onSvgChange: (val) => onSvgChange.call(val),
                      colors: colors,
                      svgs: svgs,
                    ),
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    gradient: AppGradients.getGradient(colors: activeColors),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: SvgPicture.asset(
                          'assets/svg/$activeSVG',
                          width: 22,
                          height: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'title',
                decoration: InputDecoration(
                  labelText: 'project title'.capitalize,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                  FormBuilderValidators.maxLength(20),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'description',
                decoration: InputDecoration(
                  labelText: 'Project Description'.capitalize,
                ),
                minLines: 3,
                maxLines: 5,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(10),
                  FormBuilderValidators.maxLength(90),
                ]),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              SizedBox(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      createTeam.call(formKey.currentState!.value);
                    }
                  },
                  child: const Text('Create project'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
