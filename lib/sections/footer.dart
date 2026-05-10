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
              _socialIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com/in/rohit4631'),
              const SizedBox(width: 20),
              _socialIcon(FontAwesomeIcons.github, 'https://github.com/rohit4631'),
              const SizedBox(width: 20),
              _socialIcon(FontAwesomeIcons.instagram, 'https://www.instagram.com/_rohit.____01'),
              const SizedBox(width: 20),
              _socialIcon(FontAwesomeIcons.envelope, 'mailto:kr5273860@gmail.com?subject=Portfolio%20Inquiry'),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Built with Flutter ❤️',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            '© ${DateTime.now().year} Rohit. All Rights Reserved.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
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
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        borderRadius: 50,
        child: FaIcon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
