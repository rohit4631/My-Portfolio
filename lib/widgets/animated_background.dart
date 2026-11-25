import 'package:flutter/material.dart';
import '../core/theme.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;

  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  final ValueNotifier<Offset> _mousePos =
      ValueNotifier(const Offset(-400, -400));

  @override
  void dispose() {
    _mousePos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        _mousePos.value = event.localPosition;
      },
      child: Stack(
        children: [
          // Background layer isolated with RepaintBoundary
          RepaintBoundary(
            child: Stack(
              children: [
                // Base background color
                Container(
                  color: AppTheme.background,
                ),

                // Top-right static ambient glow (Purple)
                Positioned(
                  top: -150,
                  right: -150,
                  child: IgnorePointer(
                    child: Container(
                      width: 550,
                      height: 550,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.primary.withValues(alpha: 0.18),
                            AppTheme.primary.withValues(alpha: 0.05),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.4, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),

                // Center-left static ambient glow (Blue)
                Positioned(
                  top: 700,
                  left: -180,
                  child: IgnorePointer(
                    child: Container(
                      width: 600,
                      height: 600,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.secondary.withValues(alpha: 0.15),
                            AppTheme.secondary.withValues(alpha: 0.04),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.45, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),

                // Interactive glowing orb that tracks mouse cursor smoothly
                ValueListenableBuilder<Offset>(
                  valueListenable: _mousePos,
                  builder: (context, pos, _) {
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 120),
                      curve: Curves.easeOutCubic,
                      left: pos.dx - 225,
                      top: pos.dy - 225,
                      child: IgnorePointer(
                        child: Container(
                          width: 450,
                          height: 450,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppTheme.primary.withValues(alpha: 0.22),
                                AppTheme.secondary.withValues(alpha: 0.10),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.4, 1.0],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Foreground child in its own RepaintBoundary for smooth 60/120fps scrolling
          RepaintBoundary(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
