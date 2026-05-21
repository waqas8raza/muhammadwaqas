import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/hover_item.dart';

class HeroSection extends ConsumerStatefulWidget {
  const HeroSection({super.key});

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _blobController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    // Blob rotation and pulse animation
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Floating tech icon hover animation
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blobController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 960;
    final isMobile = screenWidth < 600;

    return Stack(
      children: [
        // Premium Floating Background Blobs (Mesh gradient look)
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _blobController,
            builder: (context, child) {
              final angle = _blobController.value * 2 * math.pi;
              return Stack(
                children: [
                  Positioned(
                    top: 100 + math.sin(angle) * 50,
                    right: isDesktop ? 150 + math.cos(angle) * 50 : 20,
                    child: Container(
                      width: isDesktop ? 300 : 180,
                      height: isDesktop ? 300 : 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.primaryEmerald.withOpacity(0.18),
                            AppTheme.accentEmerald.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50 + math.cos(angle) * 40,
                    left: isDesktop ? 100 + math.sin(angle) * 40 : 10,
                    child: Container(
                      width: isDesktop ? 250 : 150,
                      height: isDesktop ? 250 : 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF0EA5E9).withOpacity(0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        // Hero Main Content Layout
        Container(
          constraints: BoxConstraints(
            minHeight: isDesktop ? 700 : 550,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 64 : 24,
            vertical: isDesktop ? 120 : 60,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: () {
              final textColumnWidget = AnimationLimiter(
                child: Column(
                  crossAxisAlignment: isDesktop
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 600),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      // Premium "Available for Hire" Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryEmerald.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppTheme.primaryEmerald.withOpacity(
                              0.25,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppTheme.accentEmerald,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.accentEmerald,
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Available for Projects",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppTheme.accentEmerald,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Main Title Headline
                      RichText(
                        textAlign: isDesktop
                            ? TextAlign.left
                            : TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                fontSize: isMobile
                                    ? 38
                                    : isDesktop
                                    ? 64
                                    : 48,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                              ),
                          children: const [
                            TextSpan(text: "Hi, I am \n"),
                            TextSpan(
                              text: PortfolioData.name,
                              style: TextStyle(
                                color: AppTheme.accentEmerald,
                                shadows: [
                                  Shadow(
                                    color: AppTheme.glowEmerald,
                                    blurRadius: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Sub-Headline (Title)
                      Text(
                        PortfolioData.title,
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              fontSize: isMobile ? 24 : 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 16),

                      // Short bio subtitle statement
                      SizedBox(
                        width: 550,
                        child: Text(
                          PortfolioData.subtitle,
                          textAlign: isDesktop
                              ? TextAlign.left
                              : TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppTheme.textSecondary,
                                fontSize: isMobile ? 16 : 18,
                              ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Call to Action Buttons
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          HoverItem(
                            scale: 1.05,
                            builder: (context, isHovered) => ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(scrollNotifierProvider)
                                    .scrollToSection('Projects');
                                ref
                                        .read(
                                          activeSectionProvider.notifier,
                                        )
                                        .state =
                                    'Projects';
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryEmerald,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: isHovered ? 12 : 0,
                                shadowColor: AppTheme.accentEmerald
                                    .withOpacity(0.5),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "View My Work",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HoverItem(
                            scale: 1.05,
                            builder: (context, isHovered) => OutlinedButton(
                              onPressed: () {
                                ref
                                    .read(scrollNotifierProvider)
                                    .scrollToSection('Contact');
                                ref
                                        .read(
                                          activeSectionProvider.notifier,
                                        )
                                        .state =
                                    'Contact';
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(
                                  color: isHovered
                                      ? AppTheme.accentEmerald
                                      : Colors.white.withOpacity(0.2),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Let's Talk",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Social Connections
                      Row(
                        mainAxisAlignment: isDesktop
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          _buildSocialIcon(
                            icon: Icons.code_rounded,
                            tooltip: "GitHub",
                            url: PortfolioData.github,
                          ),
                          const SizedBox(width: 16),
                          _buildSocialIcon(
                            icon: Icons.chat_bubble_outline_rounded,
                            tooltip: "LinkedIn",
                            url: PortfolioData.linkedin,
                          ),
                          const SizedBox(width: 16),
                          _buildSocialIcon(
                            icon: Icons.phone_android_rounded,
                            tooltip: "WhatsApp",
                            url: PortfolioData.whatsapp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );

              final profileDisplayWidget = Stack(
                alignment: Alignment.center,
                children: [
                  // Decorative glowing ring
                  Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryEmerald.withOpacity(0.15),
                        width: 1.5,
                      ),
                    ),
                  ),
                  // Outer glowing ring
                  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.accentEmerald.withOpacity(0.3),
                        width: 2.5,
                      ),
                    ),
                  ),
                  // Central Profile Glassmorphism Card
                  Hero(
                    tag: 'avatar_card',
                    child: GlassContainer(
                      width: 240,
                      height: 240,
                      borderRadius: BorderRadius.circular(120),
                      opacity: 0.1,
                      bgColor: AppTheme.primaryEmerald.withOpacity(0.05),
                      borderColor: AppTheme.accentEmerald.withOpacity(
                        0.5,
                      ),
                      child: Center(
                        child: Container(
                          width: 220,
                          height: 220,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primaryEmerald,
                                Color(0xFF0F766E),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              PortfolioData.profileImage,
                              fit: BoxFit.cover,
                              width: 220,
                              height: 220,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.flutter_dash,
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Floating Tech Bubbles animated in sinus waves
                  _buildFloatingBubble(
                    icon: Icons.code,
                    offset: const Offset(-150, -100),
                    label: "Dart",
                    animationMultiplier: 1.0,
                  ),
                  _buildFloatingBubble(
                    icon: Icons.waves,
                    offset: const Offset(130, -60),
                    label: "Riverpod",
                    animationMultiplier: 1.5,
                  ),
                  _buildFloatingBubble(
                    icon: Icons.waves,
                    offset: const Offset(-150, 70),
                    label: "GetX",
                    animationMultiplier: 1.5,
                  ),
                  _buildFloatingBubble(
                    icon: Icons.waves,
                    offset: const Offset(140, 50),
                    label: "Bloc",
                    animationMultiplier: 1.5,
                  ),
                  _buildFloatingBubble(
                    icon: Icons.local_fire_department_rounded,
                    offset: const Offset(-120, 120),
                    label: "Firebase",
                    animationMultiplier: 1.2,
                  ),
                  _buildFloatingBubble(
                    icon: Icons.auto_awesome,
                    offset: const Offset(120, 110),
                    label: "AI Systems",
                    animationMultiplier: 0.8,
                  ),
                ],
              );

              final mobileAvatarWidget = Hero(
                tag: 'avatar_card',
                child: GlassContainer(
                  width: 160,
                  height: 160,
                  borderRadius: BorderRadius.circular(80),
                  opacity: 0.1,
                  bgColor: AppTheme.primaryEmerald.withOpacity(0.05),
                  borderColor: AppTheme.accentEmerald.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryEmerald,
                            Color(0xFF0F766E),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          PortfolioData.profileImage,
                          fit: BoxFit.cover,
                          width: 140,
                          height: 140,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.flutter_dash,
                                size: 60,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );

              return Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isDesktop) ...[
                    mobileAvatarWidget,
                    const SizedBox(height: 24),
                  ],
                  if (isDesktop)
                    Expanded(
                      flex: 6,
                      child: textColumnWidget,
                    )
                  else
                    textColumnWidget,
                  if (isDesktop) ...[
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 4,
                      child: profileDisplayWidget,
                    ),
                  ],
                ],
              );
            }(),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String tooltip,
    required String url,
  }) {
    return HoverItem(
      scale: 1.15,
      builder: (context, isHovered) => IconButton(
        onPressed: () => _launchUrl(url),
        tooltip: tooltip,
        icon: Icon(
          icon,
          color: isHovered ? AppTheme.accentEmerald : Colors.white60,
          size: 24,
        ),
        style: IconButton.styleFrom(
          backgroundColor: isHovered
              ? AppTheme.primaryEmerald.withOpacity(0.15)
              : Colors.white.withOpacity(0.03),
          padding: const EdgeInsets.all(12),
          side: BorderSide(
            color: isHovered
                ? AppTheme.primaryEmerald.withOpacity(0.4)
                : Colors.white.withOpacity(0.08),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingBubble({
    required IconData icon,
    required Offset offset,
    required String label,
    required double animationMultiplier,
  }) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final double hoverOffset =
            math.sin(
              (_floatController.value * 2 * math.pi) +
                  (animationMultiplier * math.pi / 2),
            ) *
            12.0;

        return Positioned(
          left: (MediaQuery.of(context).size.width / 8) + offset.dx,
          top: 120 + offset.dy + hoverOffset,
          child: HoverItem(
            scale: 1.1,
            builder: (context, isHovered) => GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              borderRadius: BorderRadius.circular(30),
              opacity: 0.15,
              bgColor: AppTheme.background.withOpacity(0.6),
              borderColor: isHovered
                  ? AppTheme.accentEmerald
                  : AppTheme.primaryEmerald.withOpacity(0.3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 16, color: AppTheme.accentEmerald),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
