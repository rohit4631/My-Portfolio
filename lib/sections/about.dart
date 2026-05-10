import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../core/theme.dart';
import '../core/responsive.dart';
import '../widgets/glass_container.dart';
import '../viewmodels/visibility_viewmodel.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    final isVisible = ref.watch(visibilityProvider)['about-section'] ?? false;
    
    return VisibilityDetector(
      key: const Key('about-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          ref.read(visibilityProvider.notifier).setVisible('about-section', true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Me',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 40),
            if (isMobile) ...[
              _buildTextContent(context),
              const SizedBox(height: 40),
              _buildStats(context),
            ] else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildTextContent(context)),
                  const SizedBox(width: 80),
                  Expanded(flex: 2, child: _buildStats(context)),
                ],
              ),
          ],
        ),
      ).animate(target: isVisible ? 1 : 0).fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Flutter Developer with 2+ years of experience building scalable, high-performance Android, iOS, and Web applications using Flutter and Dart. Passionate about creating modern, responsive, and user-friendly applications with clean architecture and optimized performance.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        Text(
          "Experienced in developing production-level applications with advanced integrations including Google Maps, payment gateways, real-time sockets, push notifications, authentication systems, audio/video calling, cloud services, and REST APIs.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        Text(
          "Strong understanding of state management solutions like Bloc, Provider, and GetX along with responsive UI development and reusable component architecture.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        Text(
          "Focused on writing maintainable and scalable code while delivering smooth user experiences across multiple platforms.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 40),
        _buildInfoGrid(context),
      ],
    );
  }

  Widget _buildInfoGrid(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _infoRow(context, 'Experience:', '2+ Years'),
          const Divider(color: Colors.white24, height: 24),
          _infoRow(context, 'Role:', 'Flutter Developer'),
          const Divider(color: Colors.white24, height: 24),
          _infoRow(context, 'Platforms:', 'Android, iOS, Web App'),
          const Divider(color: Colors.white24, height: 24),
          _infoRow(context, 'Location:', 'Mohali, India'),
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
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
        ),
        Expanded(
          flex: 3,
          child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    return Column(
      children: [
        _statCard(context, '2+', 'Years Experience', Icons.timer_outlined),
        const SizedBox(height: 20),
        _statCard(context, '10+', 'Projects Completed', Icons.cases_outlined),
        const SizedBox(height: 20),
        _statCard(context, '5+', 'Core Tech Stacks', Icons.code),
        const SizedBox(height: 20),
        GlassContainer(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tech Highlights',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _techBadge('Flutter'),
                  _techBadge('Dart'),
                  _techBadge('Firebase'),
                  _techBadge('REST API'),
                  _techBadge('Bloc'),
                  _techBadge('GetX'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(BuildContext context, String value, String label, IconData icon) {
    return _HoverableStatCard(value: value, label: label, icon: icon);
  }

  Widget _techBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.15),
        border: Border.all(color: AppTheme.primary.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _HoverableStatCard extends StatefulWidget {
  final String value;
  final String label;
  final IconData icon;

  const _HoverableStatCard({required this.value, required this.label, required this.icon});

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
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          borderColor: _isHovered ? AppTheme.primary.withOpacity(0.6) : AppTheme.glassBorder,
          child: Row(
            children: [
              Icon(widget.icon, size: 40, color: _isHovered ? Colors.white : AppTheme.primary),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                      child: Text(
                        widget.value,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white, 
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
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
