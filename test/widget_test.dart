import 'package:flutter_test/flutter_test.dart';
import 'package:rohit_portfolio/repositories/portfolio_repository.dart';

void main() {
  test('Portfolio repository data test', () {
    final repo = PortfolioRepository();
    final skills = repo.getSkills();
    final experiences = repo.getExperiences();
    final projects = repo.getProjects();
    final education = repo.getEducation();

    expect(skills.isNotEmpty, true);
    expect(experiences.length, 2);
    expect(experiences.first.company, 'Lagran Software Solutions');
    expect(projects.length, 5);
    expect(projects.first.title, 'Lagran HR (HRMS)');
    expect(education.length, 2);
  });
}
