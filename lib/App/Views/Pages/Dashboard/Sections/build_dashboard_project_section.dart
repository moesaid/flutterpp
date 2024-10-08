import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Dashboard/dashboard_controller.dart';
import 'package:flutterpp/App/Models/project_model.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_create_project.dart';
import 'package:flutterpp/App/Views/Pages/Dashboard/Widgets/build_dashboard_project_item.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardProjectSection extends StatelessWidget {
  const BuildDashboardProjectSection({
    super.key,
    required this.controller,
  });

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('projects'.capitalize!),
        SizedBox(height: 3.spa),
        Row(
          children: [
            BuildDashboardCreateProject(controller: controller),
            SizedBox(width: 5.spa),
            Expanded(
              child: SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.projects.length,
                  separatorBuilder: (context, index) => SizedBox(
                    width: 5.spa,
                  ),
                  itemBuilder: (context, index) {
                    ProjectModel item = controller.projects[index];
                    return BuildDashboardProjectItem(
                      item: item,
                      onTap: () => controller.navigateToProject(item),
                      controller: controller,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
