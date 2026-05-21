import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/hover_item.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1150;
    final isMobile = screenWidth < 600;

    int crossAxisCount = 4;
    if (isDesktop) {
      crossAxisCount = 6;
    } else if (screenWidth > 800) {
      crossAxisCount = 4;
    } else if (screenWidth > 500) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
    }

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
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 2,
                    color: AppTheme.accentEmerald,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "STACK",
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
                "Technologies",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 16),
              const Text(
                "A curated list of frameworks, tools, and platforms that I use to design and deploy high-performance applications.",
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 15),
              ),
              const SizedBox(height: 48),

              // Animated Tech Badge Grid
              AnimationLimiter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 110,
                  ),
                  itemCount: PortfolioData.technologies.length,
                  itemBuilder: (context, index) {
                    final tech = PortfolioData.technologies[index];
                    final IconData icon = tech["icon"];
                    final String name = tech["name"];

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: crossAxisCount,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: HoverItem(
                            scale: 1.05,
                            builder: (context, isHovered) => GlassContainer(
                              padding: const EdgeInsets.all(16),
                              borderRadius: BorderRadius.circular(16),
                              opacity: isHovered ? 0.12 : 0.06,
                              borderColor: isHovered
                                  ? AppTheme.accentEmerald.withOpacity(0.4)
                                  : Colors.white.withOpacity(0.08),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon,
                                    size: 32,
                                    color: isHovered ? AppTheme.accentEmerald : Colors.white70,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isHovered ? Colors.white : AppTheme.textPrimary,
                                      fontWeight: isHovered ? FontWeight.bold : FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
}
