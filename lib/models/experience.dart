class Experience {
  final String role;
  final String company;
  final String location;
  final String type;
  final String period;
  final List<String> responsibilities;
  final List<String> technologies;

  const Experience({
    required this.role,
    required this.company,
    required this.location,
    required this.type,
    required this.period,
    required this.responsibilities,
    this.technologies = const [],
  });
}
