import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/theme.dart';
import '../core/responsive.dart';
import '../widgets/glass_container.dart';
import '../viewmodels/visibility_viewmodel.dart';
import '../viewmodels/portfolio_viewmodel.dart';
import '../models/project.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    final isVisible = ref.watch(visibilityProvider)['projects-section'] ?? false;
    final projects = ref.watch(projectsProvider);
    
    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !isVisible) {
          ref.read(visibilityProvider.notifier).setVisible('projects-section', true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Featured Projects',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Some things I\'ve built recently.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3),
                childAspectRatio: 0.75,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return _buildProjectCard(context, projects[index], index, isVisible);
              },
            ),
          ],
        ),
      ).animate(target: isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index, bool isVisible) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(project.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Content
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.title, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 22)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withAlpha(51),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(tag, style: const TextStyle(color: AppTheme.primary, fontSize: 12)),
                      );
                    }).toList(),
                  ),
                  // Buttons removed
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(target: isVisible ? 1 : 0).fadeIn(delay: (200 * index).ms).scale(begin: const Offset(0.9, 0.9));
  }
}
