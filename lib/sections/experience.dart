import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../core/theme.dart';
import '../core/responsive.dart';
import '../widgets/glass_container.dart';
import '../viewmodels/visibility_viewmodel.dart';
import '../viewmodels/portfolio_viewmodel.dart';
import '../models/experience.dart';

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    final isVisible = ref.watch(visibilityProvider)['experience-section'] ?? false;
    final experiences = ref.watch(experiencesProvider);
    
    return VisibilityDetector(
      key: const Key('experience-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !isVisible) {
          ref.read(visibilityProvider.notifier).setVisible('experience-section', true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional Experience',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 40),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                return _buildExperienceItem(context, exp, index, isMobile, isVisible);
              },
            ),
          ],
        ),
      ).animate(target: isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildExperienceItem(BuildContext context, Experience exp, int index, bool isMobile, bool isVisible) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: GlassContainer(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(exp.role, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 26, color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withAlpha(51), // 0.2 opacity
                      border: Border.all(color: AppTheme.primary.withAlpha(128)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(exp.period, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            else ...[
              Text(exp.role, style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24, color: Colors.white)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withAlpha(51),
                  border: Border.all(color: AppTheme.primary.withAlpha(128)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(exp.period, style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
            const SizedBox(height: 12),
            Text(exp.company, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.secondary, fontSize: 20)),
            const SizedBox(height: 24),
            ...exp.responsibilities.map((resp) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 12),
                    child: Icon(Icons.arrow_forward_ios, size: 12, color: AppTheme.primary),
                  ),
                  Expanded(
                    child: Text(
                      resp,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5, color: Colors.white70),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ).animate(target: isVisible ? 1 : 0).fadeIn(delay: (150 * index).ms).slideX(begin: 0.1, end: 0),
    );
  }
}
