import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;
import '../core/theme/app_theme.dart';
import '../providers/portfolio_providers.dart';
import 'glass_container.dart';

class Navbar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  ConsumerState<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _NavbarState extends ConsumerState<Navbar>
    with SingleTickerProviderStateMixin {
  bool _isMobileMenuOpen = false;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;

  final List<String> _navItems = [
    'Home',
    'About',
    'Skills',
    'Experience',
    'Projects',
    'Tech',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOutBack,
    );
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMobileMenu() {
    setState(() {
      _isMobileMenuOpen = !_isMobileMenuOpen;
      if (_isMobileMenuOpen) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

Future<void> _downloadCV() async {
    const url =
        "https://raw.githubusercontent.com/waqas8raza/portfoliodata/main/MuhammadWaqasResume.pdf";

    html.AnchorElement(href: url)
      ..setAttribute("download", "MuhammadWaqasResume.pdf")
      ..click();
  }
  @override
  Widget build(BuildContext context) {
    final activeSection = ref.watch(activeSectionProvider);
    final scrollNotifier = ref.read(scrollNotifierProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1150;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlassContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                borderRadius: BorderRadius.circular(50),
                opacity: 0.1,
                bgColor: AppTheme.background.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo
                    InkWell(
                      onTap: () {
                        ref.read(activeSectionProvider.notifier).state = 'Home';
                        scrollNotifier.scrollToSection('Home');
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryEmerald.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.primaryEmerald.withOpacity(0.4),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/me.jpeg",
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              text: "Waqas",
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.5,
                                  ),
                              children: const [
                                TextSpan(
                                  text: ".",
                                  style: TextStyle(
                                    color: AppTheme.accentEmerald,
                                    fontSize: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Navigation Links (Desktop)
                    if (isDesktop)
                      Row(
                        children: _navItems.map((item) {
                          final isActive = activeSection == item;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextButton(
                              onPressed: () {
                                ref.read(activeSectionProvider.notifier).state =
                                    item;
                                scrollNotifier.scrollToSection(item);
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: isActive
                                    ? AppTheme.accentEmerald
                                    : Colors.white70,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item,
                                    style: TextStyle(
                                      fontWeight: isActive
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                                  ),
                                  if (isActive)
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        color: AppTheme.accentEmerald,
                                        shape: BoxShape.circle,
                                      ),
                                    )
                                  else
                                    const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    // Actions / Menu Toggle
                    Row(
                      children: [
                        if (isDesktop)
                          ElevatedButton.icon(
                            onPressed: _downloadCV,
                            icon: const Icon(Icons.download_rounded, size: 18),
                            label: const Text("Download CV"),
                            style:
                                ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryEmerald,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: AppTheme.accentEmerald
                                      .withOpacity(0.5),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ).copyWith(
                                  elevation: ButtonStyleButton.allOrNull(0),
                                ),
                          )
                        else
                          IconButton(
                            onPressed: _toggleMobileMenu,
                            icon: AnimatedIcon(
                              icon: AnimatedIcons.menu_close,
                              progress: _menuController,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Mobile Menu Expandable Panel
              if (!isDesktop && _isMobileMenuOpen)
                SizeTransition(
                  sizeFactor: _menuAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16),
                      borderRadius: BorderRadius.circular(24),
                      opacity: 0.15,
                      bgColor: AppTheme.background.withOpacity(0.85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ..._navItems.map((item) {
                            final isActive = activeSection == item;
                            return ListTile(
                              onTap: () {
                                _toggleMobileMenu();
                                ref.read(activeSectionProvider.notifier).state =
                                    item;
                                scrollNotifier.scrollToSection(item);
                              },
                              title: Text(
                                item,
                                style: TextStyle(
                                  color: isActive
                                      ? AppTheme.accentEmerald
                                      : Colors.white,
                                  fontWeight: isActive
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              trailing: isActive
                                  ? const Icon(
                                      Icons.chevron_right,
                                      color: AppTheme.accentEmerald,
                                    )
                                  : null,
                            );
                          }),
                          const Divider(color: Colors.white10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _toggleMobileMenu();
                                _downloadCV();
                              },
                              icon: const Icon(Icons.download_rounded),
                              label: const Text("Download CV"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryEmerald,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
