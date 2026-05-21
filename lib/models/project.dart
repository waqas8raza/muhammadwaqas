class Project {
  final String title;
  final String description;
  final List<String> features;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl;
  final String category; // 'Mobile', 'Enterprise', 'AI & Utilities', 'Other'

  const Project({
    required this.title,
    required this.description,
    required this.features,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.imageUrl,
    required this.category,
  });
}
