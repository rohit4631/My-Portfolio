import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/glass_container.dart';
import '../core/theme.dart';
import '../core/responsive.dart';
import '../viewmodels/visibility_viewmodel.dart';

class HeaderNavigation extends ConsumerStatefulWidget {
  final Function(int) onNavTap;

  const HeaderNavigation({super.key, required this.onNavTap});

  @override
  ConsumerState<HeaderNavigation> createState() => _HeaderNavigationState();
}

class _HeaderNavigationState extends ConsumerState<HeaderNavigation> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _handleNavTap(int index) {
    widget.onNavTap(index);
    if (_isMenuOpen) {
      setState(() => _isMenuOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeSection = ref.watch(activeSectionProvider);
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isCompact = !isDesktop;
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          GlassContainer(
            borderRadius: 0,
            blur: 12,
            padding: EdgeInsets.only(
              left: isCompact ? 16 : 32,
              right: isCompact ? 8 : 32,
              top: (isCompact ? 12 : 16) + topPadding,
              bottom: isCompact ? 12 : 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isCompact ? 8 : 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'RK',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Rohit',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                      ),
                      Text(
                        '.dev',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isDesktop)
                  Row(
                    children: [
                      _navLink('Home', 0, activeSection),
                      _navLink('About', 1, activeSection),
                      _navLink('Skills', 2, activeSection),
                      _navLink('Experience', 3, activeSection),
                      _navLink('Projects', 4, activeSection),
                      _navLink('Contact', 5, activeSection),
                    ],
                  )
                else
                  IconButton(
                    icon: Icon(_isMenuOpen ? Icons.close : Icons.menu,
                        color: Colors.white),
                    onPressed: _toggleMenu,
                    splashRadius: 24,
                  ),
              ],
            ),
          ),
          if (isCompact)
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: _isMenuOpen ? 360 : 0,
              width: double.infinity,
              child: ClipRRect(
                child: GlassContainer(
                  borderRadius: 0,
                  blur: 16,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _mobileNavLink('Home', 0, activeSection),
                        _mobileNavLink('About', 1, activeSection),
                        _mobileNavLink('Skills', 2, activeSection),
                        _mobileNavLink('Experience', 3, activeSection),
                        _mobileNavLink('Projects', 4, activeSection),
                        _mobileNavLink('Contact', 5, activeSection),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _navLink(String title, int index, int activeIndex) {
    final isActive = index == activeIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () => _handleNavTap(index),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive
                ? AppTheme.primary.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? AppTheme.primary.withValues(alpha: 0.6)
                  : Colors.transparent,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : AppTheme.textSecondary,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobileNavLink(String title, int index, int activeIndex) {
    final isActive = index == activeIndex;
    return InkWell(
      onTap: () => _handleNavTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withValues(alpha: 0.12)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isActive ? AppTheme.primary : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppTheme.primary : Colors.white,
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
