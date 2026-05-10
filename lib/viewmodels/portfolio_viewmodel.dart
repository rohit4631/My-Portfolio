import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/skill.dart';
import '../models/experience.dart';
import '../models/project.dart';
import '../repositories/portfolio_repository.dart';

final portfolioRepositoryProvider = Provider<PortfolioRepository>((ref) {
  return PortfolioRepository();
});

final skillsProvider = Provider<List<SkillCategory>>((ref) {
  final repo = ref.watch(portfolioRepositoryProvider);
  return repo.getSkills();
});

final experiencesProvider = Provider<List<Experience>>((ref) {
  final repo = ref.watch(portfolioRepositoryProvider);
  return repo.getExperiences();
});

final projectsProvider = Provider<List<Project>>((ref) {
  final repo = ref.watch(portfolioRepositoryProvider);
  return repo.getProjects();
});
