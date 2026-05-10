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

class ContactSection extends ConsumerWidget {
  ContactSection({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMobile = ResponsiveLayout.isMobile(context);
    final isVisible = ref.watch(visibilityProvider)['contact-section'] ?? false;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !isVisible) {
          ref
              .read(visibilityProvider.notifier)
              .setVisible('contact-section', true);
        }
      },
      child:
          Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 80,
                  vertical: 60,
                ),
                child: Column(
                  children: [
                    Text(
                      'Get In Touch',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Have a project in mind? Let\'s work together.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),
                    if (isMobile)
                      Column(
                        children: [
                          _buildContactInfo(context),
                          const SizedBox(height: 40),
                          _buildContactForm(context),
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _buildContactInfo(context)),
                          const SizedBox(width: 80),
                          Expanded(flex: 3, child: _buildContactForm(context)),
                        ],
                      ),
                  ],
                ),
              )
              .animate(target: isVisible ? 1 : 0)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 30),
        _HoverableContactCard(
          icon: Icons.email_outlined,
          title: 'Email',
          subtitle: 'kr5273860@gmail.com',
          url: 'mailto:kr5273860@gmail.com?subject=Portfolio%20Inquiry',
        ),
        const SizedBox(height: 16),
        _HoverableContactCard(
          icon: Icons.phone_outlined,
          title: 'Phone',
          subtitle: '+91 8091744631',
          url: 'tel:+918091744631',
        ),
        const SizedBox(height: 16),
        const _HoverableContactCard(
          icon: Icons.location_on_outlined,
          title: 'Location',
          subtitle: 'Mohali, India',
          url: null,
        ),
        const SizedBox(height: 40),
        Text('Social Media', style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 20),
        Row(
          children: [
            _socialIcon(
              FontAwesomeIcons.github,
              'https://github.com/rohit4631',
            ),
            const SizedBox(width: 16),
            _socialIcon(
              FontAwesomeIcons.linkedin,
              'https://linkedin.com/in/rohit4631',
            ),
            const SizedBox(width: 16),
            _socialIcon(
              FontAwesomeIcons.instagram,
              'https://www.instagram.com/_rohit.____01',
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialIcon(dynamic icon, String url) {
    return _HoverableSocialIcon(icon: icon, url: url);
  }

  Widget _buildContactForm(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Name', 'John Doe'),
            const SizedBox(height: 20),
            _buildTextField('Email', 'john@example.com'),
            const SizedBox(height: 20),
            _buildTextField('Message', 'Hello...', maxLines: 5),
            const SizedBox(height: 30),
            _HoverableSubmitButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Send message logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent successfully!')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        labelStyle: const TextStyle(color: AppTheme.textSecondary),
        filled: true,
        fillColor: Colors.white.withAlpha(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primary),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Email' &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }
}

class _HoverableContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? url;

  const _HoverableContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.url,
  });

  @override
  State<_HoverableContactCard> createState() => _HoverableContactCardState();
}

class _HoverableContactCardState extends State<_HoverableContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.url != null
            ? () async {
                final uri = Uri.parse(widget.url!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(_isHovered ? 10 : 0, 0, 0),
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            borderColor: _isHovered
                ? AppTheme.primary.withOpacity(0.5)
                : AppTheme.glassBorder,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppTheme.primary
                        : AppTheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: _isHovered ? Colors.white : AppTheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.url != null)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: _isHovered ? AppTheme.primary : Colors.transparent,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverableSocialIcon extends StatefulWidget {
  final FaIconData icon;
  final String url;

  const _HoverableSocialIcon({required this.icon, required this.url});

  @override
  State<_HoverableSocialIcon> createState() => _HoverableSocialIconState();
}

class _HoverableSocialIconState extends State<_HoverableSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _isHovered ? AppTheme.primary : AppTheme.cardBackground,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? AppTheme.primary : AppTheme.glassBorder,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: FaIcon(widget.icon, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }
}

class _HoverableSubmitButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _HoverableSubmitButton({required this.onPressed});

  @override
  State<_HoverableSubmitButton> createState() => _HoverableSubmitButtonState();
}

class _HoverableSubmitButtonState extends State<_HoverableSubmitButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onPressed,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            gradient: _isHovered ? AppTheme.primaryGradient : null,
            color: _isHovered ? null : AppTheme.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.translationValues(_isHovered ? 5 : 0, 0, 0),
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
