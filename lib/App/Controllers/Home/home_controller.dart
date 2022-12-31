import 'package:flutter/material.dart';
import 'package:flutterpp/App/Services/Auth/auth_services.dart';
import 'package:flutterpp/App/Services/team_services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final AuthServices _authServices = AuthServices();
  final TeamServices _teamServices = TeamServices();

  final _isInTeam = true.obs;
  bool get isInTeam => _isInTeam.value;

  final _tabs = [
    {
      'title': 'dashboard',
      'icon': HeroIcons.home,
      'isActive': true,
      'tab': ElevatedButton(
        onPressed: () async {
          await AuthServices().signOut();
        },
        child: const Text('data'),
      ),
    },
    {
      'title': 'projects',
      'icon': HeroIcons.squaresPlus,
      'isActive': false,
      'tab': const Text('projects'),
    },
    {
      'title': 'chat',
      'icon': HeroIcons.chatBubbleOvalLeftEllipsis,
      'isActive': false,
      'tab': const Text('chat'),
    },
    {
      'title': 'invoices',
      'icon': HeroIcons.banknotes,
      'isActive': false,
      'tab': const Text('invoices'),
    },
    {
      'title': 'time tracking',
      'icon': HeroIcons.clock,
      'isActive': false,
      'tab': const Text('time tracking'),
    },
    {
      'title': 'scrum',
      'icon': HeroIcons.rectangleStack,
      'isActive': false,
      'tab': const Text('scrum'),
    },
    {
      'title': 'witeboard',
      'icon': HeroIcons.paintBrush,
      'isActive': false,
      'tab': const Text('witeboard'),
    },
  ].obs;

  List<Map<String, dynamic>> get tabs => _tabs;

  final _selectedTab = 0.obs;
  int get selectedTab => _selectedTab.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  Future<void> onReady() async {
    await _checkIfUserIsInTeam();

    _isLoading.value = false;
    update();

    super.onReady();
  }

  // change tab
  void changeTab(int index) {
    for (var element in _tabs) {
      element['isActive'] = false;
    }
    _tabs[index]['isActive'] = true;
    _selectedTab.value = index;
    update();
  }

  // check if user is in team
  Future<void> _checkIfUserIsInTeam() async {
    User? user = _authServices.currentUser();

    _isInTeam.value = await _teamServices.isUserInTeam(user!.id);
    update();
  }
}
