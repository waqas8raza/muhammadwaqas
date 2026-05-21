import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../models/project.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/hover_item.dart';
import '../../widgets/tech_badge.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  void _showProjectDetails(BuildContext context, Project project) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650, maxHeight: 600),
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: GlassContainer(
                padding: const EdgeInsets.all(28),
                borderRadius: BorderRadius.circular(28),
                opacity: 0.12,
                bgColor: AppTheme.background.withOpacity(0.9),
                borderColor: AppTheme.primaryEmerald.withOpacity(0.4),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryEmerald.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              project.category.toUpperCase(),
                              style: const TextStyle(
                                color: AppTheme.accentEmerald,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white70,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      if (project.imageUrl != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            project.imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                            errorBuilder: (context, error, stackTrace) {
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Project Title
                      Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Project Description
                      Text(
                        project.description,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Key Features List
                      const Text(
                        "Key Features",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...project.features.map(
                        (feat) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(
                                  Icons.circle,
                                  size: 6,
                                  color: AppTheme.accentEmerald,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  feat,
                                  style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Technologies Used
                      const Text(
                        "Technologies Used",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies
                            .map((tech) => TechBadge(label: tech))
                            .toList(),
                      ),
                      const SizedBox(height: 32),

                      // Action buttons
                      Row(
                        children: [
                          if (project.githubUrl != null ||
                              PortfolioData.github.isNotEmpty)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _launchUrl(
                                  project.githubUrl ?? PortfolioData.github,
                                ),
                                icon: const Icon(Icons.code_rounded),
                                label: const Text("GitHub Repo"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryEmerald,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _launchUrl(
                                project.liveUrl ?? PortfolioData.github,
                              ),
                              icon: const Icon(Icons.launch_rounded),
                              label: const Text("Live Demo"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white24),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 960;
    final isTablet = screenWidth > 640 && screenWidth <= 960;
    final isMobile = screenWidth <= 640;

    final activeFilter = ref.watch(selectedProjectFilterProvider);
    final searchQuery = ref.watch(projectSearchQueryProvider);

    // Apply Filter & Search logic
    final filteredProjects = PortfolioData.projects.where((proj) {
      final matchesCategory =
          activeFilter == 'All' || proj.category == activeFilter;
      final matchesSearch =
          proj.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          proj.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
          proj.technologies.any(
            (tech) => tech.toLowerCase().contains(searchQuery.toLowerCase()),
          );
      return matchesCategory && matchesSearch;
    }).toList();

    int crossAxisCount = 3;
    if (isDesktop) {
      crossAxisCount = 3;
    } else if (isTablet) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    final categories = ['All', 'Mobile', 'Enterprise', 'AI & Utilities'];

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
              // Header Row
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 2,
                    color: AppTheme.accentEmerald,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "PORTFOLIO",
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
                "Featured Projects",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 32),

              // Filter Controls & Search Row
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: isDesktop
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.stretch,
                children: [
                  // Search Bar
                  Expanded(
                    flex: isDesktop ? 4 : 0,
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      borderRadius: BorderRadius.circular(16),
                      opacity: 0.08,
                      child: TextField(
                        onChanged: (val) {
                          ref.read(projectSearchQueryProvider.notifier).state =
                              val;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                          hintText: "Search by project or technology...",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  if (isDesktop)
                    const SizedBox(width: 24)
                  else
                    const SizedBox(height: 16),

                  // Category Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final isSelected = activeFilter == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              cat,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (val) {
                              if (val) {
                                ref
                                        .read(
                                          selectedProjectFilterProvider
                                              .notifier,
                                        )
                                        .state =
                                    cat;
                              }
                            },
                            selectedColor: AppTheme.primaryEmerald,
                            backgroundColor: Colors.white.withOpacity(0.04),
                            checkmarkColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected
                                    ? AppTheme.accentEmerald.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.08),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Empty Search Result Placeholder
              if (filteredProjects.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Column(
                      children: [
                        Icon(
                          Icons.folder_off_rounded,
                          size: 64,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "No projects match your query.",
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                // Grid of filtered projects
                AnimationLimiter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 440,
                    ),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];

                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: crossAxisCount,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: HoverItem(
                              scale: 1.02,
                              builder: (context, isHovered) => GlassContainer(
                                padding: EdgeInsets.zero,
                                borderRadius: BorderRadius.circular(24),
                                opacity: isHovered ? 0.1 : 0.06,
                                borderColor: isHovered
                                    ? AppTheme.accentEmerald.withOpacity(0.4)
                                    : Colors.white.withOpacity(0.08),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(24),
                                  onTap: () =>
                                      _showProjectDetails(context, project),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Top half card banner
                                      Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: _getCategoryGradient(
                                              project.category,
                                            ),
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(24),
                                              ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(24),
                                          ),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              if (project.imageUrl != null)
                                                Image.asset(
                                                  project.imageUrl!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        Container(
                                                          color: Colors.black.withOpacity(0.15),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            padding: const EdgeInsets.all(16),
                                                            decoration: BoxDecoration(
                                                              color: Colors.white.withOpacity(0.15),
                                                              shape: BoxShape.circle,
                                                              border: Border.all(
                                                                color: Colors.white.withOpacity(0.25),
                                                                width: 1,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              project.title.substring(0, 1),
                                                              style: const TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 32,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                )
                                              else
                                                Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Container(
                                                      color: Colors.black.withOpacity(0.15),
                                                    ),
                                                    Center(
                                                      child: Container(
                                                        padding: const EdgeInsets.all(16),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.15),
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.white.withOpacity(0.25),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          project.title.substring(0, 1),
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 32,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              // Category tag
                                              Positioned(
                                                top: 16,
                                                left: 16,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.1),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    project.category,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Bottom details area
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                project.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Flexible(
                                                child: Text(
                                                  project.description,
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: AppTheme.textSecondary,
                                                    fontSize: 13,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              // Technology chips preview
                                              Wrap(
                                                spacing: 6,
                                                runSpacing: 6,
                                                children: project.technologies
                                                    .take(3)
                                                    .map(
                                                      (tech) => Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 4,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.04),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                          border: Border.all(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                  0.08,
                                                                ),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          tech,
                                                          style: const TextStyle(
                                                            color: AppTheme
                                                                .textSecondary,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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

  List<Color> _getCategoryGradient(String category) {
    switch (category) {
      case 'Mobile':
        return [AppTheme.primaryEmerald, const Color(0xFF0F766E)];
      case 'Enterprise':
        return [const Color(0xFF0284C7), const Color(0xFF0369A1)];
      case 'AI & Utilities':
        return [const Color(0xFF7C3AED), const Color(0xFF6D28D9)];
      default:
        return [const Color(0xFF4B5563), const Color(0xFF374151)];
    }
  }
}
