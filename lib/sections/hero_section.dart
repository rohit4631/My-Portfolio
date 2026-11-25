import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../core/theme.dart';
import '../core/responsive.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContactTap;

  const HeroSection({
    super.key,
    this.onViewProjects,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      constraints: BoxConstraints(
        minHeight: isMobile
            ? MediaQuery.of(context).size.height * 0.90
            : MediaQuery.of(context).size.height * 0.92,
      ),
      padding: EdgeInsets.only(
        left: isMobile ? 20 : 80,
        right: isMobile ? 20 : 80,
        top: isMobile ? (70 + topPadding) : 100,
        bottom: isMobile ? 40 : 60,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Availability badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x1A10B981),
                border: Border.all(color: const Color(0x6610B981)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Available for Full-time & Remote Roles',
                    style: TextStyle(
                      color: Color(0xFF34D399),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),

            SizedBox(height: isMobile ? 24 : 32),

            // Profile Avatar with Glowing Border
            Container(
              width: isMobile ? 140 : 170,
              height: isMobile ? 140 : 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.4),
                    blurRadius: 36,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/profile.jpg',
                  width: isMobile ? 140 : 170,
                  height: isMobile ? 140 : 170,
                  fit: BoxFit.cover,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (wasSynchronouslyLoaded || frame != null) return child;
                    return Container(
                      color: AppTheme.background,
                      child: const Center(
                        child: Text(
                          'R',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppTheme.background,
                      child: const Center(
                        child: Text(
                          'R',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .moveY(begin: -6, end: 6, duration: 2500.ms, curve: Curves.easeInOut),

            SizedBox(height: isMobile ? 24 : 32),

            // Main Name Header
            Text(
              "Hi, I'm Rohit",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: isMobile ? 36 : 52,
                    fontWeight: FontWeight.w800,
                  ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),

            const SizedBox(height: 12),

            // Animated typewriter title
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.primaryGradient.createShader(bounds),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontSize: isMobile ? 20 : 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.2,
                        ) ??
                    const TextStyle(),
                textAlign: TextAlign.center,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flutter Developer | Android & iOS',
                      speed: const Duration(milliseconds: 70),
                    ),
                    TypewriterAnimatedText(
                      'Cross-Platform Mobile Applications',
                      speed: const Duration(milliseconds: 70),
                    ),
                    TypewriterAnimatedText(
                      'Location Tracking & Real-Time WebSockets',
                      speed: const Duration(milliseconds: 70),
                    ),
                    TypewriterAnimatedText(
                      'HRMS, Logistics & Consumer Apps Specialist',
                      speed: const Duration(milliseconds: 70),
                    ),
                  ],
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1400),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ).animate(delay: 150.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 16),

            // Professional summary line
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                '2+ years of professional experience building scalable cross-platform mobile applications for Android & iOS. Proven track record across HRMS, retail, logistics and matchmaking domains with clean architecture, live tracking, and seamless API integrations.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: isMobile ? 15 : 17,
                      height: 1.6,
                      color: const Color(0xFFCBD5E1),
                    ),
                textAlign: TextAlign.center,
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

            SizedBox(height: isMobile ? 28 : 36),

            // Call to action buttons
            Wrap(
              spacing: 16,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              children: [
                _actionButton(
                  context: context,
                  label: 'Explore Projects',
                  icon: Icons.cases_outlined,
                  isPrimary: true,
                  onTap: onViewProjects,
                ),
                _actionButton(
                  context: context,
                  label: 'Get In Touch',
                  icon: Icons.mail_outline,
                  isPrimary: false,
                  onTap: onContactTap,
                ),
              ],
            ).animate(delay: 250.ms).fadeIn(duration: 400.ms),

            SizedBox(height: isMobile ? 24 : 32),

            // Social Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(
                  FontAwesomeIcons.github,
                  'https://github.com/rohit4631',
                  tooltip: 'GitHub',
                ),
                const SizedBox(width: 16),
                _socialIcon(
                  FontAwesomeIcons.linkedinIn,
                  'https://linkedin.com/in/rohit4631',
                  tooltip: 'LinkedIn',
                ),
                const SizedBox(width: 16),
                _socialIcon(
                  FontAwesomeIcons.envelope,
                  'mailto:Kr5273860@gmail.com?subject=Portfolio%20Inquiry',
                  tooltip: 'Email',
                ),
              ],
            ).animate(delay: 300.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 36),

            // Quick Scroll Down Indicator
            Column(
              children: [
                Text(
                  "SCROLL TO EXPLORE",
                  style: TextStyle(
                    color: AppTheme.primary.withValues(alpha: 0.9),
                    fontSize: 11,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppTheme.primary,
                  size: 24,
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: -3, end: 3, duration: 900.ms, curve: Curves.easeInOut),
              ],
            ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _actionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isPrimary,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: isPrimary ? AppTheme.primaryGradient : null,
          color: isPrimary ? null : AppTheme.cardBackground,
          border: isPrimary
              ? null
              : Border.all(color: AppTheme.primary.withValues(alpha: 0.4)),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(dynamic icon, String url, {required String tooltip}) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.cardBackground,
            border: Border.all(color: AppTheme.glassBorder),
          ),
          child: FaIcon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
