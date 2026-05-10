import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../core/theme.dart';
import '../core/responsive.dart';
import '../widgets/glass_container.dart';
import '../viewmodels/visibility_viewmodel.dart';
import '../viewmodels/portfolio_viewmodel.dart';
import '../models/skill.dart';

class SkillsSection extends ConsumerWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    final isVisible = ref.watch(visibilityProvider)['skills-section'] ?? false;
    final skillCategories = ref.watch(skillsProvider);
    
    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !isVisible) {
          ref.read(visibilityProvider.notifier).setVisible('skills-section', true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Technical Skills',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'A categorized overview of my technical expertise and tools.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 40),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : (ResponsiveLayout.isTablet(context) ? 2 : 3),
                childAspectRatio: isMobile ? 1.5 : 1.2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              itemCount: skillCategories.length,
              itemBuilder: (context, index) {
                final category = skillCategories[index];
                return _buildSkillCategoryCard(context, category, index, isVisible);
              },
            ),
          ],
        ),
      ).animate(target: isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildSkillCategoryCard(BuildContext context, SkillCategory category, int index, bool isVisible) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.stars_rounded, color: AppTheme.primary, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ShaderMask(
                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    category.title,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: category.skills.map((skill) {
                  return _SkillChip(skill: skill);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    ).animate(target: isVisible ? 1 : 0).fadeIn(delay: (100 * index).ms).scale(begin: const Offset(0.9, 0.9));
  }
}

class _SkillChip extends StatefulWidget {
  final String skill;
  const _SkillChip({required this.skill});

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered ? AppTheme.primary.withAlpha(50) : AppTheme.primary.withAlpha(15),
          border: Border.all(
            color: _isHovered ? AppTheme.primary : AppTheme.primary.withAlpha(51),
            width: _isHovered ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: _isHovered ? [
            BoxShadow(
              color: AppTheme.primary.withAlpha(100),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 16,
              color: _isHovered ? Colors.white : AppTheme.primary,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                widget.skill,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
