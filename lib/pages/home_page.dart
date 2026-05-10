import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/visibility_viewmodel.dart';
import '../sections/header.dart';
import '../sections/hero_section.dart';
import '../sections/about.dart';
import '../sections/skills.dart';
import '../sections/experience.dart';
import '../sections/projects.dart';
import '../sections/contact.dart';
import '../sections/footer.dart';
import '../widgets/animated_background.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Keys for each section
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels < 300) {
      if (ref.read(activeSectionProvider) != 0) ref.read(activeSectionProvider.notifier).state = 0;
      return;
    }
    

    final keys = [_heroKey, _aboutKey, _skillsKey, _experienceKey, _projectsKey, _contactKey];
    for (int i = keys.length - 1; i >= 0; i--) {
      final key = keys[i];
      if (key.currentContext != null) {
        final renderBox = key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
        if (position.dy <= 150) {
          if (ref.read(activeSectionProvider) != i) {
            ref.read(activeSectionProvider.notifier).state = i;
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int sectionIndex) {
    GlobalKey? targetKey;

    switch (sectionIndex) {
      case 0:
        targetKey = _heroKey;
        break;
      case 1:
        targetKey = _aboutKey;
        break;
      case 2:
        targetKey = _skillsKey;
        break;
      case 3:
        targetKey = _experienceKey;
        break;
      case 4:
        targetKey = _projectsKey;
        break;
      case 5:
        targetKey = _contactKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      final RenderBox renderBox = targetKey.currentContext!.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject()).dy;
      

      final isMobile = MediaQuery.of(context).size.width < 800;
      final topPadding = MediaQuery.of(context).padding.top;
      final headerOffset = isMobile ? 80.0 + topPadding : 80.0;
      
      _scrollController.animateTo(
        (_scrollController.offset + offset - headerOffset).clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent,
      body: AnimatedBackground(
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HeroSection(key: _heroKey),
                  AboutSection(key: _aboutKey),
                  SkillsSection(key: _skillsKey),
                  ExperienceSection(key: _experienceKey),
                  ProjectsSection(key: _projectsKey),
                  ContactSection(key: _contactKey),
                  const FooterSection(),
                ],
              ),
            ),
            HeaderNavigation(onNavTap: _scrollToSection),
          ],
        ),
      ),
    );
  }
}
