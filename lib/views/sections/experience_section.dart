import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/hover_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 960;
    final isMobile = screenWidth < 600;

    final experience = PortfolioData.experiences.first;

    // Sub-milestones derived from the projects list to make the timeline look detailed and professional
    final List<Map<String, dynamic>> milestones = [
      {
        "year": "Feb 2024 - Present",
        "title": "Flutter Developer",
        "company": "Maxcore Technologies",
        "description": "Building production-ready mobile applications using modern architectures and scalable systems. Developed and deployed 10+ cross-platform apps including ILM, Golden Hills, and Suraj Studio.",
      },
      {
        "year": "Freelance",
        "title": "Mobile App Developer",
        "company": "Freelance Projects",
        "description": "Developed Gateline/Hostline (USA Community Security) and Faster (Spain Delivery Ecosystem). Implemented real-time tracking, WebSocket connections, live Google Map routes, QR-based check-ins, and security automation.",
      }
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
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 2,
                    color: AppTheme.accentEmerald,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "TIMELINE",
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
                "Work Experience",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 20),

              // Overview Description
              GlassContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: BorderRadius.circular(20),
                opacity: 0.05,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.work_history_rounded,
                      color: AppTheme.accentEmerald,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experience.role,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            experience.description,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // Vertical Timeline UI
              AnimationLimiter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: milestones.length,
                  itemBuilder: (context, index) {
                    final mile = milestones[index];

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Left column: Timeline node line and glow dot
                                Container(
                                  width: 40,
                                  child: Column(
                                    children: [
                                      // Top line
                                      Expanded(
                                        child: Container(
                                          width: 2,
                                          color: index == 0
                                              ? Colors.transparent
                                              : AppTheme.primaryEmerald.withOpacity(0.3),
                                        ),
                                      ),
                                      // Glowing bullet point
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: const BoxDecoration(
                                          color: AppTheme.accentEmerald,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppTheme.accentEmerald,
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Bottom line
                                      Expanded(
                                        child: Container(
                                          width: 2,
                                          color: index == milestones.length - 1
                                              ? Colors.transparent
                                              : AppTheme.primaryEmerald.withOpacity(0.3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Right column: Timeline card details
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 24),
                                    child: HoverItem(
                                      scale: 1.01,
                                      builder: (context, isHovered) => GlassContainer(
                                        padding: const EdgeInsets.all(24),
                                        borderRadius: BorderRadius.circular(20),
                                        opacity: isHovered ? 0.1 : 0.06,
                                        borderColor: isHovered
                                            ? AppTheme.accentEmerald.withOpacity(0.3)
                                            : Colors.white.withOpacity(0.08),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Period / Year badge
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: AppTheme.primaryEmerald.withOpacity(0.12),
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                mile['year'],
                                                style: const TextStyle(
                                                  color: AppTheme.accentEmerald,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            // Title & Company
                                            Text(
                                              mile['title'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              mile['company'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: AppTheme.accentEmerald.withOpacity(0.85),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            // Description
                                            Text(
                                              mile['description'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: AppTheme.textSecondary,
                                                height: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
