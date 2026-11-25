class Project {
  final String title;
  final String category;
  final String description;
  final String image;
  final List<String> tags;
  final List<String> keyFeatures;
  final String githubLink;
  final String previewLink;

  const Project({
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.tags,
    this.keyFeatures = const [],
    this.githubLink = 'https://github.com/rohit4631',
    this.previewLink = 'https://rohit4631-portfolio.vercel.app',
  });
}
