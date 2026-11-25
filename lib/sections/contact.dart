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

class ContactSection extends ConsumerStatefulWidget {
  const ContactSection({super.key});

  @override
  ConsumerState<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends ConsumerState<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      final name = Uri.encodeComponent(_nameController.text.trim());
      final body = Uri.encodeComponent(
          "Name: ${_nameController.text.trim()}\nEmail: ${_emailController.text.trim()}\n\n${_messageController.text.trim()}");
      final mailtoUri = Uri.parse(
          "mailto:Kr5273860@gmail.com?subject=Portfolio%20Inquiry%20from%20$name&body=$body");

      if (await canLaunchUrl(mailtoUri)) {
        await launchUrl(mailtoUri, mode: LaunchMode.externalApplication);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF10B981),
            content: Text(
              'Thank you! Your email client has been opened to send your inquiry.',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveLayout.isMobile(context);
    final isVisible =
        ref.watch(visibilityProvider)['contact-section'] ?? false;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: (info) {
        if ((info.visibleFraction > 0.02 || info.visibleBounds.height > 20) &&
            !isVisible) {
          ref
              .read(visibilityProvider.notifier)
              .setVisible('contact-section', true);
        }
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primary.withValues(alpha: 0.4)),
              ),
              child: const Text(
                'GET IN TOUCH',
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
              "Let's Build Something Together",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: isMobile ? 28 : 38,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              "Have a project, job opening, or need a dedicated Flutter developer? Feel free to reach out directly.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: isMobile ? 15 : 17,
                  ),
            ),
            const SizedBox(height: 40),
            if (isMobile)
              Column(
                children: [
                  _buildContactInfo(context),
                  const SizedBox(height: 36),
                  _buildContactForm(context),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: _buildContactInfo(context)),
                  const SizedBox(width: 50),
                  Expanded(flex: 3, child: _buildContactForm(context)),
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

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Details',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 24),
        _HoverableContactCard(
          icon: Icons.email_outlined,
          title: 'Direct Email',
          subtitle: 'Kr5273860@gmail.com',
          url: 'mailto:Kr5273860@gmail.com?subject=Portfolio%20Inquiry',
        ),
        const SizedBox(height: 14),
        _HoverableContactCard(
          icon: Icons.phone_outlined,
          title: 'Phone & WhatsApp',
          subtitle: '+91-8091744631',
          url: 'tel:+918091744631',
        ),
        const SizedBox(height: 14),
        _HoverableContactCard(
          icon: Icons.location_on_outlined,
          title: 'Location',
          subtitle: 'Kangra, Himachal Pradesh 176001, India',
          url: 'https://maps.google.com/?q=Kangra,+Himachal+Pradesh',
        ),
        const SizedBox(height: 14),
        _HoverableContactCard(
          icon: Icons.language_outlined,
          title: 'Portfolio Website',
          subtitle: 'rohit4631-portfolio.vercel.app',
          url: 'https://rohit4631-portfolio.vercel.app',
        ),
        const SizedBox(height: 32),
        Text(
          'Connect on Socials',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _HoverableSocialIcon(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/rohit4631',
            ),
            const SizedBox(width: 14),
            _HoverableSocialIcon(
              icon: FontAwesomeIcons.linkedinIn,
              url: 'https://linkedin.com/in/rohit4631',
            ),
            const SizedBox(width: 14),
            _HoverableSocialIcon(
              icon: FontAwesomeIcons.envelope,
              url: 'mailto:Kr5273860@gmail.com?subject=Portfolio%20Inquiry',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(28),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Quick Message',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _nameController,
              label: 'Your Name',
              hint: 'e.g. Alex Morgan',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              label: 'Your Email',
              hint: 'e.g. alex@company.com',
              isEmail: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _messageController,
              label: 'Message / Project Details',
              hint: 'Tell me about your app requirements or role...',
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            _HoverableSubmitButton(
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    bool isEmail = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
        labelStyle:
            const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.04),
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
          borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        if (isEmail &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
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
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.015 : 1.0,
            _isHovered ? 1.015 : 1.0,
            1.0,
          ),
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            borderColor: _isHovered
                ? AppTheme.primary.withValues(alpha: 0.5)
                : AppTheme.glassBorder,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppTheme.primary
                        : AppTheme.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.icon,
                    color: _isHovered ? Colors.white : AppTheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (widget.url != null)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: _isHovered
                        ? AppTheme.primary
                        : Colors.white.withValues(alpha: 0.2),
                    size: 14,
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
  final dynamic icon;
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppTheme.primary
                : AppTheme.cardBackground,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? AppTheme.primary
                  : AppTheme.glassBorder,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: (widget.icon is FaIconData)
              ? FaIcon(
                  widget.icon as FaIconData,
                  color: Colors.white,
                  size: 18,
                )
              : Icon(
                  widget.icon as IconData,
                  color: Colors.white,
                  size: 18,
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: _isHovered ? AppTheme.primaryGradient : null,
            color: _isHovered ? null : AppTheme.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: _isHovered ? 0.45 : 0.25),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.send_rounded, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
