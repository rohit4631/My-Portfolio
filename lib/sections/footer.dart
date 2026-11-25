import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/theme.dart';
import '../widgets/glass_container.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.glassBorder)),
      ),
      child: Column(
        children: [
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
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Engineered with Flutter & Dart',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.favorite, color: Color(0xFFEF4444), size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '© ${DateTime.now().year} Rohit Kumar • Kangra, HP, India. All Rights Reserved.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: AppTheme.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(
    dynamic icon,
    String url, {
    required String tooltip,
    bool isMaterialIcon = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: GlassContainer(
          padding: const EdgeInsets.all(12),
          borderRadius: 50,
          child: isMaterialIcon
              ? Icon(icon as IconData, color: Colors.white, size: 18)
              : FaIcon(icon as FaIconData, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}
