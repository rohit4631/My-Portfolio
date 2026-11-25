import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../core/theme.dart';
import '../core/responsive.dart';
import '../widgets/glass_container.dart';
import '../viewmodels/visibility_viewmodel.dart';
import '../viewmodels/portfolio_viewmodel.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isVisible = ref.watch(visibilityProvider)['about-section'] ?? false;
    final educationList = ref.watch(educationProvider);

    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if ((info.visibleFraction > 0.02 || info.visibleBounds.height > 20) &&
            !isVisible) {
          ref
              .read(visibilityProvider.notifier)
              .setVisible('about-section', true);
        }
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section title badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primary.withValues(alpha: 0.4)),
              ),
              child: const Text(
                'ABOUT ME',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Crafting High-Performance Mobile Experiences',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isMobile ? 28 : 38,
                  ),
            ),
            const SizedBox(height: 40),
            if (isMobile) ...[
              _buildTextContent(context),
              const SizedBox(height: 36),
              _buildStats(context),
              const SizedBox(height: 36),
              _buildEducation(context, educationList),
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextContent(context),
                        const SizedBox(height: 32),
                        _buildEducation(context, educationList),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    flex: 2,
                    child: _buildStats(context),
                  ),
                ],
              ),
          ],
        ),
      )
          .animate(target: isVisible ? 1 : 0)
          .fadeIn(duration: 350.ms)
          .slideY(begin: 0.05, end: 0, duration: 350.ms, curve: Curves.easeOutCubic),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I am a passionate Flutter Developer with 2+ years of professional experience designing, building, and maintaining robust cross-platform applications for Android and iOS.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.7,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          "My engineering focus centers on clean architecture, predictable state management (Riverpod, Provider, GetX, MobX, BLoC), and responsive UI/UX. I specialize in complex business domains including HRMS enterprise systems, retail supply chains, multi-app logistics, and social matchmaking applications.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
        ),
        const SizedBox(height: 16),
        Text(
          "I have deep hands-on expertise implementing location-based workflows—such as live employee GPS tracking, sales-visit logging, route history mapping, and interactive visit-map visualisations with Google Maps. I enjoy collaborating with backend teams to integrate REST APIs, WebSockets, push notifications, and payment gateways into smooth, production-ready experiences.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
        ),
        const SizedBox(height: 28),
        _buildInfoGrid(context),
      ],
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _infoRow(context, 'Role:', 'Flutter & Mobile Developer'),
          const Divider(color: AppTheme.glassBorder, height: 20),
          _infoRow(context, 'Experience:', '2+ Years Professional'),
          const Divider(color: AppTheme.glassBorder, height: 20),
          _infoRow(context, 'Target Platforms:', 'Android, iOS, Web'),
          const Divider(color: AppTheme.glassBorder, height: 20),
          _infoRow(context, 'Location:', 'Kangra, Himachal Pradesh, India'),
          const Divider(color: AppTheme.glassBorder, height: 20),
          _infoRow(context, 'Work Preference:', 'Remote / Hybrid / On-site'),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEducation(BuildContext context, List<dynamic> educationList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.school_outlined,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Education',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...educationList.map(
          (edu) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassContainer(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.history_edu,
                      color: AppTheme.secondary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                edu.degree,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'GPA: ${edu.gpa}',
                                style: const TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${edu.institution} • ${edu.location}',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${edu.period} (${edu.mode})',
                          style: const TextStyle(
                            color: AppTheme.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    return Column(
      children: [
        _statCard(context, '2+', 'Years Professional Experience',
            Icons.access_time_rounded),
        const SizedBox(height: 16),
        _statCard(context, '5+', 'Production Apps Delivered',
            Icons.devices_other_rounded),
        const SizedBox(height: 16),
        _statCard(context, '10+', 'Core Stacks & Integrations',
            Icons.integration_instructions_outlined),
        const SizedBox(height: 16),
        GlassContainer(
          padding: const EdgeInsets.all(22),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Competencies',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _techBadge('Flutter & Dart'),
                  _techBadge('Google Maps GPS'),
                  _techBadge('WebSockets'),
                  _techBadge('Riverpod / BLoC'),
                  _techBadge('HRMS Workflows'),
                  _techBadge('Stripe Payments'),
                  _techBadge('Firebase FCM'),
                  _techBadge('Clean Architecture'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(
      BuildContext context, String value, String label, IconData icon) {
    return _HoverableStatCard(value: value, label: label, icon: icon);
  }

  Widget _techBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.12),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HoverableStatCard extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;

  const _HoverableStatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  State<_HoverableStatCard> createState() => _HoverableStatCardState();
}

class _HoverableStatCardState extends State<_HoverableStatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _isHovered ? 1.015 : 1.0,
          _isHovered ? 1.015 : 1.0,
          1.0,
        ),
        child: GlassContainer(
          padding: const EdgeInsets.all(22),
          width: double.infinity,
          borderColor: _isHovered
              ? AppTheme.primary.withValues(alpha: 0.6)
              : AppTheme.glassBorder,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: _isHovered ? 0.25 : 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: _isHovered ? Colors.white : AppTheme.primary,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppTheme.primaryGradient.createShader(bounds),
                      child: Text(
                        widget.value,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
