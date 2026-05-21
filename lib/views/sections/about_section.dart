import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/hover_item.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 960;
    final isMobile = screenWidth < 600;

    // Define icons corresponding to each specialization in order
    final List<IconData> specIcons = [
      Icons.flutter_dash_rounded,
      Icons.schema_rounded,
      Icons.api_rounded,
      Icons.sync_alt_rounded,
      Icons.auto_awesome_rounded,
      Icons.devices_other,
      Icons.speed_rounded,
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 64 : 24,
            vertical: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: -50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 2,
                            color: AppTheme.accentEmerald,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            "ABOUT ME",
                            style: TextStyle(
                              color: AppTheme.accentEmerald,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Who I Am",
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              fontSize: isMobile ? 28 : 36,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Main Narrative & Visual Grid layout
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Biography Block
                  Expanded(
                    flex: isDesktop ? 5 : 0,
                    child: GlassContainer(
                      padding: const EdgeInsets.all(28),
                      borderRadius: BorderRadius.circular(24),
                      opacity: 0.08,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "My Journey",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            PortfolioData.aboutText,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  color: AppTheme.textSecondary,
                                  fontSize: 16,
                                  height: 1.6,
                                ),
                          ),
                          const SizedBox(height: 24),
                          // Stat badges
                          Row(
                            children: [
                              _buildStat(context, "2+", "Years Exp"),
                              const SizedBox(width: 32),
                              _buildStat(context, "13+", "Projects Built"),
                              const SizedBox(width: 32),
                              _buildStat(context, "100%", "Quality Deliveries"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (isDesktop)
                    const SizedBox(width: 40)
                  else
                    const SizedBox(height: 40),

                  // Specializations Grid Block
                  Expanded(
                    flex: isDesktop ? 6 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, bottom: 16.0),
                          child: Text(
                            "Specializations",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: PortfolioData.specializations.length,
                          itemBuilder: (context, index) {
                            final spec = PortfolioData.specializations[index];
                            final icon = index < specIcons.length
                                ? specIcons[index]
                                : Icons.check_circle_outline;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: HoverItem(
                                scale: 1.02,
                                offset: const Offset(
                                  4,
                                  0,
                                ), // slide right slightly
                                builder: (context, isHovered) => GlassContainer(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  opacity: isHovered ? 0.12 : 0.06,
                                  borderColor: isHovered
                                      ? AppTheme.accentEmerald.withOpacity(0.4)
                                      : Colors.white.withOpacity(0.08),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: isHovered
                                              ? AppTheme.primaryEmerald
                                                    .withOpacity(0.25)
                                              : AppTheme.primaryEmerald
                                                    .withOpacity(0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          icon,
                                          color: isHovered
                                              ? AppTheme.accentEmerald
                                              : Colors.white70,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          spec,
                                          style: TextStyle(
                                            color: isHovered
                                                ? Colors.white
                                                : AppTheme.textPrimary,
                                            fontWeight: isHovered
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 12,
                                        color: isHovered
                                            ? AppTheme.accentEmerald
                                            : Colors.white24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.accentEmerald,
            fontWeight: FontWeight.w900,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
