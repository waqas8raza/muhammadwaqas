import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../models/project.dart';
import '../../providers/portfolio_providers.dart';
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

  void _showProjectDetails(BuildContext context, Project project, int index) {
    showDialog(
      context: context,
      barrierColor: const Color(0xFF141518).withValues(alpha: 0.6),
      builder: (context) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720, maxHeight: 720),
            child: Dialog(
              backgroundColor: AppTheme.surface,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: AppTheme.border),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentLight,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppTheme.accentBorder),
                                ),
                                child: Text(
                                  "CASE STUDY #${(index + 1).toString().padLeft(2, '0')}",
                                  style: GoogleFonts.jetBrainsMono(
                                    color: AppTheme.accentDark,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceSubtle,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppTheme.border),
                                ),
                                child: Text(
                                  project.category,
                                  style: GoogleFonts.jetBrainsMono(
                                    color: AppTheme.textSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: AppTheme.textSecondary,
                              size: 20,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: AppTheme.surfaceSubtle,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Image
                      if (project.imageUrl != null) ...[
                        Container(
                          width: double.infinity,
                          height: 240,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceSubtle,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.border),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              project.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => const Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 40,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Project Title
                      Text(
                        project.title,
                        style: GoogleFonts.newsreader(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Description
                      Text(
                        project.description,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppTheme.textSecondary,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Key Features List
                      Text(
                        "ENGINEERING & ARCHITECTURAL HIGHLIGHTS",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textMuted,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...project.features.map(
                        (feat) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: AppTheme.accent,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  feat,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: AppTheme.textPrimary,
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Technologies Used
                      Text(
                        "CORE TECHNOLOGIES",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textMuted,
                          letterSpacing: 0.5,
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
                      const SizedBox(height: 28),

                      // Action Buttons
                      Row(
                        children: [
                          if (project.githubUrl != null ||
                              PortfolioData.github.isNotEmpty)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _launchUrl(
                                  project.githubUrl ?? PortfolioData.github,
                                ),
                                icon: const Icon(Icons.code_rounded, size: 16),
                                label: const Text("View Code Repository"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.accent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  textStyle: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _launchUrl(
                                project.liveUrl ?? PortfolioData.github,
                              ),
                              icon: const Icon(
                                Icons.arrow_outward_rounded,
                                size: 16,
                              ),
                              label: const Text("Demo / Details"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.textPrimary,
                                side: const BorderSide(color: AppTheme.border),
                                backgroundColor: AppTheme.surfaceSubtle,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                textStyle: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.5,
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

    final categories = ['All', 'Mobile', 'Enterprise', 'AI & Utilities'];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 24,
            vertical: isDesktop ? 72 : 48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Category Label
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    "01",
                    style: GoogleFonts.jetBrainsMono(
                      color: AppTheme.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(width: 16, height: 1, color: AppTheme.borderStrong),
                  Text(
                    "SELECTED WORK & CASE STUDIES",
                    style: GoogleFonts.jetBrainsMono(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Section Headline & Description
              Text(
                "Engineering Case Studies",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: isMobile ? 32 : 40,
                    ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Text(
                  "A curated selection of production applications I designed and developed at Maxcore Technologies and for international clients. Each study highlights real architecture, performance challenges, and shipped features.",
                  style: GoogleFonts.plusJakartaSans(
                    color: AppTheme.textSecondary,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 36),

              // Filter Controls & Search Row
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: isDesktop
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.stretch,
                children: [
                  // Category Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final isSelected = activeFilter == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(selectedProjectFilterProvider.notifier)
                                  .state = cat;
                            },
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.accent
                                    : AppTheme.surface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isSelected
                                      ? AppTheme.accent
                                      : AppTheme.border,
                                ),
                              ),
                              child: Text(
                                cat == 'All' ? 'All Projects' : cat,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  if (isDesktop)
                    const Spacer()
                  else
                    const SizedBox(height: 16),

                  // Search Bar
                  Container(
                    width: isDesktop ? 320 : double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.border),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          size: 18,
                          color: AppTheme.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            onChanged: (val) {
                              ref
                                  .read(projectSearchQueryProvider.notifier)
                                  .state = val;
                            },
                            style: GoogleFonts.plusJakartaSans(
                              color: AppTheme.textPrimary,
                              fontSize: 13,
                            ),
                            decoration: const InputDecoration(
                              hintText: "Search projects or tech...",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Empty Search Result Placeholder
              if (filteredProjects.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.search_off_rounded,
                        size: 40,
                        color: AppTheme.textMuted,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "No projects match \"$searchQuery\"",
                        style: GoogleFonts.plusJakartaSans(
                          color: AppTheme.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Try searching for another technology (e.g. Riverpod, AI, WebSocket)",
                        style: GoogleFonts.plusJakartaSans(
                          color: AppTheme.textMuted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
              else ...[
                // If filter is 'All' and no search query, highlight the first project as an editorial spotlight!
                if (activeFilter == 'All' &&
                    searchQuery.isEmpty &&
                    filteredProjects.isNotEmpty) ...[
                  _buildFeaturedCaseStudy(
                    context,
                    filteredProjects.first,
                    0,
                    isDesktop,
                  ),
                  const SizedBox(height: 28),
                ],

                // Grid of Remaining Projects
                _buildProjectsGrid(
                  context,
                  (activeFilter == 'All' && searchQuery.isEmpty)
                      ? filteredProjects.sublist(1)
                      : filteredProjects,
                  (activeFilter == 'All' && searchQuery.isEmpty) ? 1 : 0,
                  isDesktop,
                  isMobile,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Hero Spotlight Card for the Top Featured Case Study
  Widget _buildFeaturedCaseStudy(
    BuildContext context,
    Project project,
    int index,
    bool isDesktop,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141518).withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: _buildFeaturedImage(project, isDesktop),
                ),
                Expanded(
                  flex: 6,
                  child: _buildFeaturedContent(context, project, index),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFeaturedImage(project, isDesktop),
                _buildFeaturedContent(context, project, index),
              ],
            ),
    );
  }

  Widget _buildFeaturedImage(Project project, bool isDesktop) {
    return Container(
      height: isDesktop ? 380 : 220,
      decoration: BoxDecoration(
        color: AppTheme.surfaceSubtle,
        borderRadius: isDesktop
            ? const BorderRadius.horizontal(left: Radius.circular(9))
            : const BorderRadius.vertical(top: Radius.circular(9)),
        border: Border(
          right: isDesktop
              ? const BorderSide(color: AppTheme.border)
              : BorderSide.none,
          bottom: !isDesktop
              ? const BorderSide(color: AppTheme.border)
              : BorderSide.none,
        ),
      ),
      child: ClipRRect(
        borderRadius: isDesktop
            ? const BorderRadius.horizontal(left: Radius.circular(9))
            : const BorderRadius.vertical(top: Radius.circular(9)),
        child: project.imageUrl != null
            ? Image.asset(
                project.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Center(
                  child: Icon(Icons.apps, size: 48, color: AppTheme.textMuted),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildFeaturedContent(
    BuildContext context,
    Project project,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.accentLight,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppTheme.accentBorder),
                ),
                child: Text(
                  "FEATURED CASE STUDY",
                  style: GoogleFonts.jetBrainsMono(
                    color: AppTheme.accentDark,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                project.category,
                style: GoogleFonts.jetBrainsMono(
                  color: AppTheme.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            project.title,
            style: GoogleFonts.newsreader(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            project.description,
            style: GoogleFonts.plusJakartaSans(
              color: AppTheme.textSecondary,
              fontSize: 14.5,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies
                .take(5)
                .map((tech) => TechBadge(label: tech))
                .toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => _showProjectDetails(context, project, index),
                icon: const Icon(Icons.arrow_outward_rounded, size: 15),
                label: const Text("View Case Study"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  textStyle: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2-Column Responsive Editorial Grid for Remaining Projects
  Widget _buildProjectsGrid(
    BuildContext context,
    List<Project> projects,
    int offsetIndex,
    bool isDesktop,
    bool isMobile,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = isDesktop
            ? (constraints.maxWidth - 20) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: List.generate(projects.length, (i) {
            final project = projects[i];
            final actualIndex = offsetIndex + i;

            return SizedBox(
              width: itemWidth,
              child: HoverItem(
                scale: 1.01,
                offset: const Offset(0, -2),
                builder: (context, isHovered) => InkWell(
                  onTap: () =>
                      _showProjectDetails(context, project, actualIndex),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isHovered
                            ? AppTheme.accentBorder
                            : AppTheme.border,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF141518).withValues(
                            alpha: isHovered ? 0.06 : 0.02,
                          ),
                          blurRadius: isHovered ? 16 : 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Top Screenshot
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceSubtle,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(9),
                            ),
                            border: const Border(
                              bottom: BorderSide(color: AppTheme.border),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(9),
                            ),
                            child: project.imageUrl != null
                                ? Image.asset(
                                    project.imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => const Center(
                                      child: Icon(
                                        Icons.image_outlined,
                                        size: 32,
                                        color: AppTheme.textMuted,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),

                        // Card Content
                        Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "0${actualIndex + 1} / ${project.category.toUpperCase()}",
                                    style: GoogleFonts.jetBrainsMono(
                                      color: AppTheme.accent,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_outward_rounded,
                                    size: 15,
                                    color: AppTheme.textMuted,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                project.title,
                                style: GoogleFonts.newsreader(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textPrimary,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                project.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppTheme.textSecondary,
                                  fontSize: 13.5,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: project.technologies
                                    .take(4)
                                    .map((t) => TechBadge(label: t))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
