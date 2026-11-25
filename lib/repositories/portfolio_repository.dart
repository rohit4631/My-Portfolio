import '../models/skill.dart';
import '../models/experience.dart';
import '../models/project.dart';
import '../models/education.dart';

class PortfolioRepository {
  List<SkillCategory> getSkills() {
    return const [
      SkillCategory(
        title: 'Core & Mobile Development',
        skills: [
          'Flutter',
          'Dart',
          'Android Development',
          'iOS Development',
          'Responsive UI/UX',
          'Cross-Platform Apps',
        ],
      ),
      SkillCategory(
        title: 'State Management',
        skills: [
          'Riverpod',
          'Provider',
          'GetX',
          'MobX',
          'BLoC',
        ],
      ),
      SkillCategory(
        title: 'APIs, Real-Time & Backend',
        skills: [
          'REST API Integration',
          'WebSockets',
          'Firebase Suite',
          'Push Notifications (FCM)',
          'Cloud Services',
          'JSON Serialization',
        ],
      ),
      SkillCategory(
        title: 'Location & Tracking Workflows',
        skills: [
          'Google Maps SDK',
          'Live Employee Tracking',
          'Route History Tracking',
          'Visit-Map Visualisation',
          'Geofencing & GPS',
        ],
      ),
      SkillCategory(
        title: 'Payments & Integrations',
        skills: [
          'Stripe Payment Gateway',
          'Razorpay Integration',
          'User Authentication',
          'Deep Linking',
          'Third-Party SDKs',
        ],
      ),
      SkillCategory(
        title: 'Architecture & Engineering',
        skills: [
          'Clean Architecture',
          'Performance Optimisation',
          'Modular Codebase',
          'Reusable Components',
          'Git & GitHub',
          'CI/CD & App Deployment',
        ],
      ),
    ];
  }

  List<Experience> getExperiences() {
    return const [
      Experience(
        role: 'Flutter Developer',
        company: 'Lagran Software Solutions',
        location: 'Hyderabad, Telangana, India',
        type: 'Full-time • Remote',
        period: 'May 2026 – October 2026',
        responsibilities: [
          'Developed and enhanced Flutter features for Android and iOS, integrating backend APIs and maintaining consistent user experiences.',
          'Worked on HRMS modules covering employee management, attendance, leave, payroll, expenses and asset management.',
          'Implemented location-based workflows including live employee tracking, sales-visit tracking, route history and visit-map visualisation.',
          'Collaborated with backend and cross-functional teams to resolve issues, refine requirements and deliver production-ready updates.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'Google Maps',
          'Live GPS Tracking',
          'HRMS Modules',
          'REST APIs',
          'Clean Architecture',
        ],
      ),
      Experience(
        role: 'Flutter Developer',
        company: 'Touchwood Technologies',
        location: 'Mohali district, Punjab, India',
        type: 'Full-time • On-site',
        period: 'May 2024 – April 2026',
        responsibilities: [
          'Built and maintained cross-platform mobile applications using Flutter and Dart, from UI implementation through API integration and release support.',
          'Created reusable UI components and modular code, using state management practices to improve maintainability.',
          'Integrated REST APIs, Firebase services and push notifications; investigated bugs and improved application stability and performance.',
          'Worked with designers, backend developers and stakeholders to deliver features and support ongoing releases.',
        ],
        technologies: [
          'Flutter',
          'Dart',
          'State Management',
          'Firebase',
          'FCM Push Notifications',
          'REST APIs',
          'App Store & Play Store',
        ],
      ),
    ];
  }

  List<Project> getProjects() {
    return const [
      Project(
        title: 'Lagran HR (HRMS)',
        category: 'Enterprise & HRMS Platform',
        description:
            'Comprehensive employee management and attendance platform featuring live employee tracking, sales-visit tracking, route history, visit maps, leave management, payroll, expense claims and asset management.',
        image:
            'https://images.unsplash.com/photo-1551836022-d5d88e9218df?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Google Maps', 'Live GPS Tracking', 'HRMS', 'REST APIs', 'Clean Architecture'],
        keyFeatures: [
          'Live employee & sales-visit GPS tracking with route history',
          'Visit-map visualisation with interactive location markers',
          'Complete lifecycle: Attendance, Leave, Payroll, Expenses & Assets',
        ],
        githubLink: 'https://github.com/rohit4631',
        previewLink: 'https://rohit4631-portfolio.vercel.app',
      ),
      Project(
        title: 'Bright Future',
        category: 'Health & Wellness Direct-Selling',
        description:
            'Direct-selling platform developed for Bright Future Lifecare, supporting its health and wellness product business and connecting customers with an independent distributor network.',
        image:
            'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Direct Selling', 'E-Commerce', 'Distributor Network', 'Payments', 'REST APIs'],
        keyFeatures: [
          'Scalable product catalog with wellness ordering flows',
          'Independent distributor hierarchy and commission management',
          'Integrated payment gateway and secure customer portal',
        ],
        githubLink: 'https://github.com/rohit4631',
        previewLink: 'https://rohit4631-portfolio.vercel.app',
      ),
      Project(
        title: 'GoMak · Retailer, Wholesaler & Ryder Apps',
        category: 'Logistics & Multi-App Supply Chain',
        description:
            'Three connected Flutter apps for multi-wholesaler ordering, order placement, notifications and driver workflows, with live order/driver tracking and socket-based updates for timely status changes.',
        image:
            'https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'WebSockets', 'Live GPS Tracking', 'Logistics', 'Multi-App Suite', 'Driver Workflow'],
        keyFeatures: [
          'Triple-app ecosystem: Wholesaler portal, Retailer storefront, and Ryder driver app',
          'Live order & driver tracking on interactive map with real-time ETA',
          'Socket-based live status updates and instant dispatch notifications',
        ],
        githubLink: 'https://github.com/rohit4631',
        previewLink: 'https://rohit4631-portfolio.vercel.app',
      ),
      Project(
        title: 'Nathicharami App',
        category: 'Matchmaking & Social Discovery',
        description:
            'Matchmaking app featuring daily matches, profile recommendations, search and category filters, scratch cards, real-time chat, locked chat flows and payment-gateway integration.',
        image:
            'https://images.unsplash.com/photo-1516589178581-6cd7833ae3b2?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Real-Time Chat', 'Matchmaking', 'Firebase', 'Payment Gateway', 'UI/UX'],
        keyFeatures: [
          'Curated daily matches with algorithmic profile recommendations',
          'Real-time instant chat with locked/unlocked privacy gating',
          'Gamified interactive scratch cards and in-app subscription payments',
        ],
        githubLink: 'https://github.com/rohit4631',
        previewLink: 'https://rohit4631-portfolio.vercel.app',
      ),
      Project(
        title: 'Hungry Hutt',
        category: 'On-Demand Food Delivery',
        description:
            'Food delivery app enabling customers to explore food options, place orders and complete purchases securely through integrated Stripe payments.',
        image:
            'https://images.unsplash.com/photo-1526367790999-0150786686a2?auto=format&fit=crop&q=80&w=800',
        tags: ['Flutter', 'Stripe Payments', 'Food Delivery', 'Cart System', 'Responsive UI'],
        keyFeatures: [
          'Interactive restaurant & meal catalog with filterable cuisines',
          'Seamless cart workflow with live order price calculations',
          'Integrated Stripe card payments with instant verification',
        ],
        githubLink: 'https://github.com/rohit4631',
        previewLink: 'https://rohit4631-portfolio.vercel.app',
      ),
    ];
  }

  List<Education> getEducation() {
    return const [
      Education(
        degree: 'MCA – Master of Computer Applications',
        field: 'Computer Applications',
        institution: 'Chandigarh University',
        location: 'Ajitgarh, Punjab',
        period: '2024',
        gpa: '8.00 / 10.0',
        mode: 'Distance Education',
      ),
      Education(
        degree: 'BCA – Bachelor of Computer Applications',
        field: 'Computer Applications',
        institution: 'MCM DAV College',
        location: 'Kangra, Himachal Pradesh',
        period: '2019 – 2022',
        gpa: '7.4 / 10.0',
        mode: 'Regular',
      ),
    ];
  }
}
