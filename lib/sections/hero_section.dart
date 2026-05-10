import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../core/theme.dart';
import '../core/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    final topPadding = MediaQuery.of(context).padding.top;
    
    return Container(
      constraints: BoxConstraints(
        minHeight: isMobile ? MediaQuery.of(context).size.height * 0.85 : MediaQuery.of(context).size.height
      ),
      padding: EdgeInsets.only(
        left: isMobile ? 16 : 80,
        right: isMobile ? 16 : 80,
        top: isMobile ? (80 + topPadding) : 100,
        bottom: isMobile ? 40 : 60,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: isMobile ? 150 : 180,
              height: isMobile ? 150 : 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.5),
                    blurRadius: 50,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: isMobile ? 75 : 90,
                backgroundColor: AppTheme.background,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.asset(
                    'assets/images/profile.jpg',
                    width: isMobile ? 150 : 180,
                    height: isMobile ? 150 : 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .moveY(begin: -10, end: 10, duration: 2.seconds, curve: Curves.easeInOut),
             
            SizedBox(height: isMobile ? 30 : 40),
            
            Text(
              "Hi, I'm Rohit 👋",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: isMobile ? 32 : null,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
            
            SizedBox(height: isMobile ? 12 : 16),
            
            ShaderMask(
              shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 24 : null,
                  fontWeight: FontWeight.bold,
                ) ?? const TextStyle(),
                textAlign: TextAlign.center,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Flutter Developer', speed: const Duration(milliseconds: 100)),
                    TypewriterAnimatedText('Android & iOS Mobile App Engineer', speed: const Duration(milliseconds: 100)),
                    TypewriterAnimatedText('Web Developer', speed: const Duration(milliseconds: 100)),
                    TypewriterAnimatedText('UI/UX Enthusiast', speed: const Duration(milliseconds: 100)),
                  ],
                  repeatForever: true,
                  pause: const Duration(milliseconds: 1500),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
            
            SizedBox(height: isMobile ? 16 : 24),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 100),
              child: Text(
                'Passionate Flutter Developer with 2+ years of experience building scalable, high-performance Android, iOS, and Web applications using Flutter and Dart.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: isMobile ? 15 : null,
                  height: isMobile ? 1.5 : null,
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ).animate(delay: 400.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),
            
            SizedBox(height: isMobile ? 24 : 30),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(FontAwesomeIcons.github, 'https://github.com/rohit4631'),
                const SizedBox(width: 20),
                _socialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com/in/rohit4631'),
                const SizedBox(width: 20),
                _socialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/_rohit.____01'),
              ],
            ).animate(delay: 600.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

              const SizedBox(height: 40),
              Column(
                children: [
                  Text(
                    "Scroll Down",
                    style: TextStyle(
                      color: AppTheme.primary.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(Icons.keyboard_arrow_down, color: AppTheme.primary, size: 28)
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .moveY(begin: -4, end: 4, duration: 1.seconds, curve: Curves.easeInOut),
                ],
              ).animate(delay: 1000.ms).fadeIn(duration: 800.ms),
            ],
        ),
      ),
    );
  }

  Widget _socialIcon(dynamic icon, String url) {
    return InkWell(
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
        child: FaIcon(icon, color: Colors.white, size: 24),
      ),
    );
  }

  Widget _ctaButton(BuildContext context, String text, IconData icon, bool isPrimary) {
    return InkWell(
      onTap: () {}, // Add navigation or download logic here
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: isPrimary ? AppTheme.primaryGradient : null,
          color: isPrimary ? null : AppTheme.cardBackground,
          border: isPrimary ? null : Border.all(color: AppTheme.glassBorder),
          boxShadow: isPrimary
              ? [BoxShadow(color: AppTheme.primary.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
