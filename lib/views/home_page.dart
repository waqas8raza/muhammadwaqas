import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../providers/portfolio_providers.dart';
import '../widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/tech_stack_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Scroll spy algorithm to determine which section is closest to the top of the viewport
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    
    final scrollNotifier = ref.read(scrollNotifierProvider);
    final activeSectionNotifier = ref.read(activeSectionProvider.notifier);

    double minDistance = double.infinity;
    String activeSection = 'Home';

    scrollNotifier.keys.forEach((section, key) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          // Get the vertical distance from the top of the viewport
          final position = box.localToGlobal(Offset.zero);
          final distance = position.dy.abs();
          
          if (distance < minDistance) {
            minDistance = distance;
            activeSection = section;
          }
        }
      }
    });

    if (activeSectionNotifier.state != activeSection) {
      activeSectionNotifier.state = activeSection;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollNotifier = ref.read(scrollNotifierProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Scrollable layout sections
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 80), // push content below navbar
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    key: scrollNotifier.keys['Home'],
                    child: const HeroSection(),
                  ),
                  
                  // About Section
                  Container(
                    key: scrollNotifier.keys['About'],
                    child: const AboutSection(),
                  ),
                  
                  // Skills Section
                  Container(
                    key: scrollNotifier.keys['Skills'],
                    child: const SkillsSection(),
                  ),
                  
                  // Experience Section
                  Container(
                    key: scrollNotifier.keys['Experience'],
                    child: const ExperienceSection(),
                  ),
                  
                  // Projects Section
                  Container(
                    key: scrollNotifier.keys['Projects'],
                    child: const ProjectsSection(),
                  ),
                  
                  // Tech Stack Section
                  Container(
                    key: scrollNotifier.keys['Tech'],
                    child: const TechStackSection(),
                  ),
                  
                  // Contact Section
                  Container(
                    key: scrollNotifier.keys['Contact'],
                    child: const ContactSection(),
                  ),
                  
                  // Footer
                  const Footer(),
                ],
              ),
            ),
          ),

          // Sticky responsive navbar floating on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.background.withOpacity(0.95),
                    AppTheme.background.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Navbar(),
            ),
          ),
        ],
      ),
    );
  }
}
