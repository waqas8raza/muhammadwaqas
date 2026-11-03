import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;
import '../core/theme/app_theme.dart';
import '../providers/portfolio_providers.dart';

class Navbar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  ConsumerState<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => const Size.fromHeight(74);
}

class _NavbarState extends ConsumerState<Navbar>
    with SingleTickerProviderStateMixin {
  bool _isMobileMenuOpen = false;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;

  final List<Map<String, String>> _navItems = [
    {'label': 'Overview', 'key': 'Home'},
    {'label': 'Projects', 'key': 'Projects'},
    {'label': 'Skills', 'key': 'Skills'},
    {'label': 'Experience', 'key': 'Experience'},
    {'label': 'About', 'key': 'About'},
    {'label': 'Contact', 'key': 'Contact'},
  ];

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _menuAnimation = CurvedAnimation(
      parent: _menuController,
      curve: Curves.easeInOut,
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

  void _downloadCV() {
    const url =
        "https://raw.githubusercontent.com/waqas8raza/portfoliodata/main/Muhammad_Waqas_Flutter_Developer (1).pdf";
    html.AnchorElement(href: url)
      ..setAttribute("download", "MuhammadWaqasResume.pdf")
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    final activeSection = ref.watch(activeSectionProvider);
    final scrollNotifier = ref.read(scrollNotifierProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 960;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 20 : 12,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 58,
                padding: EdgeInsets.symmetric(horizontal: isDesktop ? 20 : 14),
                decoration: BoxDecoration(
                  color: AppTheme.surface.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.border, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF141518).withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand / Logo
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          scrollNotifier.scrollToSection('Home');
                          ref.read(activeSectionProvider.notifier).state =
                              'Home';
                        },
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceSubtle,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppTheme.border),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(
                                  "assets/me.jpeg",
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, _, _) => const Icon(
                                    Icons.terminal,
                                    size: 16,
                                    color: AppTheme.accent,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: "M. WAQAS",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    letterSpacing: 0.6,
                                    color: AppTheme.textPrimary,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: " / DEV",
                                      style: TextStyle(
                                        color: AppTheme.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Desktop Navigation Links
                    if (isDesktop) ...[
                      Flexible(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: _navItems.map((item) {
                              final isSelected = activeSection == item['key'];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    scrollNotifier.scrollToSection(
                                      item['key']!,
                                    );
                                    ref
                                            .read(
                                              activeSectionProvider.notifier,
                                            )
                                            .state =
                                        item['key']!;
                                  },
                                  borderRadius: BorderRadius.circular(6),
                                  hoverColor: AppTheme.surfaceSubtle,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    child: Text(
                                      item['label']!,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? AppTheme.accent
                                            : AppTheme.textSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Desktop Action Button (Resume)
                      OutlinedButton.icon(
                        onPressed: _downloadCV,
                        icon: const Icon(
                          Icons.arrow_downward_rounded,
                          size: 14,
                        ),
                        label: const Text("Resume"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.textPrimary,
                          backgroundColor: AppTheme.surfaceSubtle,
                          side: const BorderSide(color: AppTheme.border),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ] else ...[
                      // Mobile Menu Hamburger Button
                      IconButton(
                        onPressed: _toggleMobileMenu,
                        icon: Icon(
                          _isMobileMenuOpen
                              ? Icons.close_rounded
                              : Icons.menu_rounded,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Mobile Navigation Menu Dropdown
              if (!isDesktop)
                SizeTransition(
                  sizeFactor: _menuAnimation,
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppTheme.border),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF141518,
                          ).withValues(alpha: 0.06),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ..._navItems.map((item) {
                          final isSelected = activeSection == item['key'];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: InkWell(
                              onTap: () {
                                _toggleMobileMenu();
                                scrollNotifier.scrollToSection(item['key']!);
                                ref.read(activeSectionProvider.notifier).state =
                                    item['key']!;
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.accentLight
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  item['label']!,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppTheme.accent
                                        : AppTheme.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        const Divider(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            _toggleMobileMenu();
                            _downloadCV();
                          },
                          icon: const Icon(
                            Icons.arrow_downward_rounded,
                            size: 16,
                          ),
                          label: const Text("Download Resume (PDF)"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            textStyle: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
