import '../models/skill.dart';
import '../models/experience.dart';
import '../models/project.dart';

class PortfolioRepository {
  List<SkillCategory> getSkills() {
    return const [
      SkillCategory(
        title: 'Mobile Development',
        skills: ['Flutter', 'Dart', 'Android', 'iOS', 'Responsive UI'],
      ),
      SkillCategory(
        title: 'State Management',
        skills: ['Bloc', 'Provider', 'GetX'],
      ),
      SkillCategory(
        title: 'Backend & APIs',
        skills: ['REST APIs', 'Firebase', 'Socket Integration', 'Cloud Services'],
      ),
      SkillCategory(
        title: 'Advanced Integrations',
        skills: [
          'Google Maps',
          'Payment Gateways (Stripe/Razorpay)',
          'Push Notifications',
          'Audio/Video Calling',
          'Authentication',
          'Deep Linking'
        ],
      ),
      SkillCategory(
        title: 'Tools & Workflow',
        skills: ['Git & GitHub', 'Figma', 'Postman', 'CI/CD', 'Agile Workflow'],
      ),
      SkillCategory(
        title: 'Performance & Architecture',
        skills: [
          'Clean Architecture',
          'App Optimization',
          'Reusable Components',
          'Modular Development'
        ],
      ),
    ];
  }

  List<Experience> getExperiences() {
    return const [
      Experience(
        role: 'Flutter Developer',
        company: 'Touchwood Technologies',
        period: 'May 2024 – Present',
        responsibilities: [
          'Developed scalable Android, iOS, and Web applications using Flutter.',
          'Built reusable widgets and responsive UI components.',
          'Integrated REST APIs and third-party services.',
          'Implemented push notifications and real-time features.',
          'Improved app performance and maintainability.',
          'Collaborated with cross-functional teams in agile workflows.',
          'Managed production deployments and app releases.',
        ],
      ),
    ];
  }

  List<Project> getProjects() {
    return const [
      Project(
        title: 'BrightFuture LifeCare',
        description: 'MLM-based product application with Stripe payment gateway integration and user management system.',
        image: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Stripe', 'User Management', 'MLM'],
        githubLink: 'https://github.com/rohit',
        previewLink: '#',
      ),
      Project(
        title: 'Hungry Hut',
        description: 'Modern food delivery application with secure online payment integration and responsive ordering flow.',
        image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Delivery', 'Payments'],
        githubLink: 'https://github.com/rohit',
        previewLink: '#',
      ),
      Project(
        title: 'CRM Solution',
        description: 'Client and lead management platform designed to improve sales tracking and workflow efficiency.',
        image: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'CRM', 'Sales Tracking'],
        githubLink: 'https://github.com/rohit',
        previewLink: '#',
      ),
      Project(
        title: 'Make Smile',
        description: 'Scalable MLM platform with payment integration and dashboard management features.',
        image: 'https://images.unsplash.com/photo-1551434678-e076c223a692?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Dashboard', 'MLM'],
        githubLink: 'https://github.com/rohit',
        previewLink: '#',
      ),
      Project(
        title: 'Forex Mountain',
        description: 'Trading education platform with notifications, tutorials, signal systems, and advanced dashboards.',
        image: 'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Trading', 'Signals', 'Education'],
        githubLink: 'https://github.com/rohit',
        previewLink: '#',
      ),
    ];
  }
}
