import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/glass_container.dart';
import '../core/theme.dart';
import '../core/responsive.dart';
import '../viewmodels/visibility_viewmodel.dart';

class HeaderNavigation extends ConsumerStatefulWidget {
  final Function(int) onNavTap;
  
  const HeaderNavigation({Key? key, required this.onNavTap}) : super(key: key);

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
    final isMobile = ResponsiveLayout.isMobile(context);
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          GlassContainer(
            borderRadius: 0,
            blur: 15,
            padding: EdgeInsets.only(
              left: isMobile ? 16 : 24,
              right: isMobile ? 8 : 24, // Less right padding on mobile to balance hamburger icon
              top: (isMobile ? 12 : 16) + topPadding,
              bottom: isMobile ? 12 : 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isMobile ? 8 : 0),
                  child: Text(
                    'Rohit',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
                if (!isMobile)
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
                    icon: Icon(_isMenuOpen ? Icons.close : Icons.menu, color: Colors.white),
                    onPressed: _toggleMenu,
                    splashRadius: 24,
                  ),
              ],
            ),
          ),
          // Mobile dropdown menu
          if (isMobile)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: _isMenuOpen ? 400 : 0, // Increased height to comfortably fit all items including Contact
              width: double.infinity,
              child: ClipRRect(
                child: GlassContainer(
                  borderRadius: 0,
                  blur: 20,
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => _handleNavTap(index),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? AppTheme.primary : Colors.transparent,
                width: 2,
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
      ),
    );
  }

  Widget _mobileNavLink(String title, int index, int activeIndex) {
    final isActive = index == activeIndex;
    return InkWell(
      onTap: () => _handleNavTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primary.withOpacity(0.1) : Colors.transparent,
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
            fontSize: 18,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
