class Project {
  final String title;
  final String description;
  final String image;
  final List<String> tags;
  final String githubLink;
  final String previewLink;

  const Project({
    required this.title,
    required this.description,
    required this.image,
    required this.tags,
    required this.githubLink,
    required this.previewLink,
  });
}
