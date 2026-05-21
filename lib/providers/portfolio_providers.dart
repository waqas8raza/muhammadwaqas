import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// Current active section (for highlighting navbar links)
final activeSectionProvider = StateProvider<String>((ref) => 'Home');

// Filter query for project listing
final selectedProjectFilterProvider = StateProvider<String>((ref) => 'All');

// Search query for projects
final projectSearchQueryProvider = StateProvider<String>((ref) => '');

// Contact form state
final contactFormSubmittingProvider = StateProvider<bool>((ref) => false);
final contactFormSuccessProvider = StateProvider<bool?>((ref) => null);

// Navigation scroll controller wrapper
final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

// Map of sections to their respective scroll offset or indices
class ScrollNotifier extends ChangeNotifier {
  final Map<String, GlobalKey> keys = {
    'Home': GlobalKey(debugLabel: 'HomeKey'),
    'About': GlobalKey(debugLabel: 'AboutKey'),
    'Skills': GlobalKey(debugLabel: 'SkillsKey'),
    'Experience': GlobalKey(debugLabel: 'ExperienceKey'),
    'Projects': GlobalKey(debugLabel: 'ProjectsKey'),
    'Tech': GlobalKey(debugLabel: 'TechKey'),
    'Contact': GlobalKey(debugLabel: 'ContactKey'),
  };

  void scrollToSection(String sectionName) {
    final key = keys[sectionName];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}

final scrollNotifierProvider = ChangeNotifierProvider<ScrollNotifier>((ref) {
  return ScrollNotifier();
});
