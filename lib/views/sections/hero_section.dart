import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/hover_item.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 960;
    final isMobile = screenWidth < 600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 24,
            vertical: isDesktop ? 64 : 36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Asymmetrical Hero Grid
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildNarrativeColumn(
                        context,
                        ref,
                        isDesktop,
                        isMobile,
                      ),
                    ),
                    const SizedBox(width: 64),
                    Expanded(
                      flex: 4,
                      child: _buildPortraitColumn(context, isDesktop),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNarrativeColumn(context, ref, isDesktop, isMobile),
                    const SizedBox(height: 48),
                    _buildPortraitColumn(context, isDesktop),
                  ],
                ),
              const SizedBox(height: 54),

              // Architectural Metric Strip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.border),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 650;
                    if (isNarrow) {
                      return Column(
                        children: [
                          _buildMetric(
                            number: "10+",
                            label: "Shipped Applications",
                            detail: "iOS, Android & Web",
                          ),
                          const Divider(height: 24),
                          _buildMetric(
                            number: "2+",
                            label: "Years in Production",
                            detail: "At Maxcore Technologies",
                          ),
                          const Divider(height: 24),
                          _buildMetric(
                            number: "60 FPS",
                            label: "Fluid UI Standard",
                            detail: "Zero jank rendering",
                          ),
                          const Divider(height: 24),
                          _buildMetric(
                            number: "100%",
                            label: "Cross-Platform",
                            detail: "Single codebase excellence",
                          ),
                        ],
                      );
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: _buildMetric(
                            number: "10+",
                            label: "Shipped Applications",
                            detail: "iOS, Android & Web",
                          ),
                        ),
                        _buildDivider(),
                        Expanded(
                          child: _buildMetric(
                            number: "2+",
                            label: "Years in Production",
                            detail: "At Maxcore Technologies",
                          ),
                        ),
                        _buildDivider(),
                        Expanded(
                          child: _buildMetric(
                            number: "60 FPS",
                            label: "Fluid UI Standard",
                            detail: "Zero jank rendering",
                          ),
                        ),
                        _buildDivider(),
                        Expanded(
                          child: _buildMetric(
                            number: "100%",
                            label: "Cross-Platform",
                            detail: "Single codebase excellence",
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNarrativeColumn(
    BuildContext context,
    WidgetRef ref,
    bool isDesktop,
    bool isMobile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability Status Tag
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppTheme.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppTheme.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "AVAILABLE FOR MOBILE ROLES",
                  style: GoogleFonts.jetBrainsMono(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // Editorial Main Headline
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile
                      ? 36
                      : isDesktop
                          ? 52
                          : 44,
                  height: 1.12,
                ),
            children: const [
              TextSpan(
                text: "Engineering scalable, production-grade ",
              ),
              TextSpan(
                text: "mobile applications",
                style: TextStyle(
                  color: AppTheme.accent,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(text: " with Flutter."),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Role & Concise Bio Statement
        Text(
          "I am ${PortfolioData.name}, a Flutter developer with 2+ years of production experience architecting and shipping 10+ cross-platform applications across education, finance, AI utilities, security, and multi-vendor logistics ecosystems.",
          style: GoogleFonts.plusJakartaSans(
            color: AppTheme.textSecondary,
            fontSize: isMobile ? 15 : 17,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 36),

        // Calls to Action
        Wrap(
          spacing: 14,
          runSpacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                ref.read(scrollNotifierProvider).scrollToSection('Projects');
                ref.read(activeSectionProvider.notifier).state = 'Projects';
              },
              icon: const Icon(Icons.arrow_outward_rounded, size: 16),
              label: const Text("Explore Case Studies"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {
                ref.read(scrollNotifierProvider).scrollToSection('Contact');
                ref.read(activeSectionProvider.notifier).state = 'Contact';
              },
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 15),
              label: const Text("Get in Touch"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.textPrimary,
                backgroundColor: AppTheme.surface,
                side: const BorderSide(color: AppTheme.border),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 36),

        // Social Links row
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 14,
          runSpacing: 8,
          children: [
            Text(
              "Profiles:",
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildEditorialLink(
              label: "GitHub",
              url: PortfolioData.github,
            ),
            _buildEditorialLink(
              label: "LinkedIn",
              url: PortfolioData.linkedin,
            ),
            _buildEditorialLink(
              label: "WhatsApp",
              url: PortfolioData.whatsapp,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPortraitColumn(BuildContext context, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141518).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Architectural photo crop
          Container(
            height: isDesktop ? 340 : 260,
            decoration: BoxDecoration(
              color: AppTheme.surfaceSubtle,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.border),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    PortfolioData.profileImage,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (_, _, _) => const Center(
                      child: Icon(
                        Icons.person,
                        size: 64,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ),
                  // Subtle bottom vignette with location/status
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      color: const Color(0xFF141518).withValues(alpha: 0.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Muhammad Waqas",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              "Maxcore Tech",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.jetBrainsMono(
                                color: AppTheme.accentLight,
                                fontSize: 11,
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
          const SizedBox(height: 16),

          // Quick Architectural Checklist
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.surfaceSubtle,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppTheme.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PRIMARY SPECIALIZATIONS",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10.5,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: const [
                    _SpecChip(label: "Flutter & Dart"),
                    _SpecChip(label: "Riverpod & Bloc"),
                    _SpecChip(label: "Clean Architecture"),
                    _SpecChip(label: "Firebase & Supabase"),
                    _SpecChip(label: "Live WebSockets"),
                    _SpecChip(label: "AI & ML Integrations"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 48,
      color: AppTheme.border,
    );
  }

  Widget _buildMetric({
    required String number,
    required String label,
    required String detail,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: GoogleFonts.newsreader(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppTheme.accent,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            detail,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorialLink({
    required String label,
    required String url,
  }) {
    return HoverItem(
      offset: const Offset(0, -1),
      scale: 1.0,
      builder: (context, isHovered) => InkWell(
        onTap: () => _launchUrl(url),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isHovered ? AppTheme.accent : AppTheme.textPrimary,
                  decoration: isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                Icons.arrow_outward_rounded,
                size: 12,
                color: isHovered ? AppTheme.accent : AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String label;

  const _SpecChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppTheme.border),
      ),
      child: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
