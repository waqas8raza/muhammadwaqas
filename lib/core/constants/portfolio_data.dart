import 'package:flutter/material.dart';
import '../../models/project.dart';
import '../../models/skill.dart';
import '../../models/experience.dart';

class PortfolioData {
  static const String name = "Muhammad Waqas";
  static const String title = "Flutter Developer";
  static const String subtitle =
      "Building scalable, modern, and high-performance mobile applications with Flutter.";

  static const String aboutText =
      "Passionate Flutter developer with experience building scalable mobile applications across multiple industries including education, finance, AI systems, delivery ecosystems, real estate, studio management, and social platforms.";

  static const List<String> specializations = [
    "Flutter development",
    "Scalable app architecture",
    "API integrations",
    "Real-time systems",
    "AI-powered features",
    "Responsive modern UI/UX",
    "Performance optimization",
  ];

  static const List<Experience> experiences = [
    Experience(
      role: "Flutter Developer — Maxcore Technologies",
      duration: "Feb 2024 - Present (2 years)",
      description:
          "Flutter developer at Maxcore Technologies, building production-ready mobile applications using modern architectures and scalable systems. Contributed to educational, AI, security, financial, and management platforms.",
      achievements: [
        "Developed and deployed 10+ cross-platform apps for iOS, Android, and Web at Maxcore.",
        "Integrated AI features, QR scanning, real-time tracking, and payment gateways.",
        "Optimized app startup and UI performance, maintaining 60fps animations.",
        "Collaborated with international teams to deliver secure, enterprise-grade solutions.",
      ],
    ),
  ];

  static final List<SkillCategory> skillCategories = [
    const SkillCategory(
      title: "Frontend",
      skills: [
        Skill(name: "Flutter", level: 0.95, icon: Icons.flutter_dash),
        Skill(name: "Dart", level: 0.95, icon: Icons.code),
        Skill(name: "Responsive UI", level: 0.90, icon: Icons.devices_other),
        Skill(name: "Material Design", level: 0.85, icon: Icons.palette),
        Skill(name: "Animations", level: 0.88, icon: Icons.animation),
      ],
    ),
    const SkillCategory(
      title: "Backend & Services",
      skills: [
        Skill(name: "Firebase", level: 0.85, icon: Icons.local_fire_department),
        Skill(name: "Supabase", level: 0.80, icon: Icons.cloud),
        Skill(name: "REST APIs", level: 0.92, icon: Icons.api),
        Skill(name: "Authentication", level: 0.88, icon: Icons.security),
        Skill(name: "Cloud Storage", level: 0.80, icon: Icons.cloud_done),
      ],
    ),
    const SkillCategory(
      title: "Architecture",
      skills: [
        Skill(name: "Riverpod", level: 0.90, icon: Icons.waves),
        Skill(name: "Provider", level: 0.85, icon: Icons.alt_route),
        Skill(name: "GoRouter", level: 0.88, icon: Icons.route),
        Skill(name: "MVVM", level: 0.90, icon: Icons.view_quilt),
        Skill(
          name: "Clean Architecture",
          level: 0.85,
          icon: Icons.account_tree,
        ),
        Skill(
          name: "Freezed & JSON Serializer",
          level: 0.90,
          icon: Icons.data_object,
        ),
      ],
    ),
    const SkillCategory(
      title: "Advanced Features",
      skills: [
        Skill(name: "AI Integrations", level: 0.85, icon: Icons.auto_awesome),
        Skill(name: "QR Systems", level: 0.90, icon: Icons.qr_code_scanner),
        Skill(
          name: "Google Maps & Tracking",
          level: 0.88,
          icon: Icons.location_on,
        ),
        Skill(name: "Payment Integration", level: 0.85, icon: Icons.payment),
        Skill(
          name: "Push Notifications",
          level: 0.85,
          icon: Icons.notifications_active,
        ),
        Skill(
          name: "Video & Image Processing",
          level: 0.80,
          icon: Icons.video_library,
        ),
      ],
    ),
  ];

  static const String profileImage = "assets/me.jpeg";

  static const List<Project> projects = [
    Project(
      title: "ILM — Study App (Maxcore)",
      description:
          "Modern educational platform for students featuring learning modules, quizzes, educational resources, and modern UI/UX.",
      category: "Mobile",
      imageUrl: "assets/projects/ilm.jpeg",
      technologies: [
        "Flutter",
        "Riverpod",
        "REST API",
        "Quiz Engine",
        "Staggered Animations",
      ],
      features: [
        "Interactive educational modules",
        "Engaging quiz systems with instant results",
        "Student-focused personalized UI",
        "Sleek learning dashboard with stats tracker",
      ],
    ),
 
    Project(
      title: "QAF All-In Financial Platform (Maxcore)",
      description:
          "Finance and referral-based platform with deposits, earnings, and reward systems.",
      category: "Enterprise",
      imageUrl: "assets/projects/qaf.jpeg",
      technologies: [
        "Flutter",
        "Riverpod",
        "Firebase Auth",
        "Stripe API",
        "Local Auth",
      ],
      features: [
        "In-app referral codes and network structure tracking",
        "Virtual wallet management and transaction ledger",
        "Secure card deposits and withdrawals",
        "Live reward tracking and notification updates",
      ],
    ),
  
    Project(
      title: "Motion Craft Studio (Maxcore)",
      description:
          "Mobile video editing application with modern editing tools, conversion tools, and controls.",
      category: "AI & Utilities",
      imageUrl: "assets/projects/motion.png",
      technologies: ["Flutter", "FFmpeg CLI", "Image Picker", "Path Provider"],
      features: [
        "Frame-accurate video editing and trimming",
        "Fast GIF conversion from MP4 format",
        "Clean audio extraction to MP3/M4A",
        "Responsive media player with playback controls",
      ],
    ),
    Project(
      title: "Image Translator — AI OCR & Live Translation (Maxcore)",
      description:
          "AI-powered image translation application that extracts text from images, translates it into multiple languages, and overlays translated text directly onto images.",
      category: "AI & Utilities",
      imageUrl: "assets/projects/image_translator.png",
      technologies: [
        "Flutter",
        "Google ML Kit OCR",
        "Translation API",
        "Canvas Drawing",
        "Image Processing",
      ],
      features: [
        "AI-powered OCR text extraction from images",
        "Real-time multi-language text translation",
        "Overlay translated text directly onto images",
        "Voice playback for translated text pronunciation",
      ],
    ),
    Project(
      title: "Expense Tracker & House Management App (Maxcore)",
      description: "Finance and household expense management system.",
      category: "Mobile",
      imageUrl: "assets/projects/expensetracker.jpeg",
      technologies: ["Flutter", "SQLite", "Riverpod", "Syncfusion Charts"],
      features: [
        "Shared household expense tracking",
        "Budget planning and category limits",
        "Advanced budget analytics charts",
        "Push notification reminders for bills",
      ],
    ),
  
   
    Project(
      title: "Gateline/Hostline — USA Community Security (Freelance)",
      description:
          "Automated community security and visitor management system for secure residential areas. Freelance project.",
      category: "Enterprise",
      imageUrl: "assets/projects/gateline.png",
      technologies: [
        "Flutter",
        "GoRouter",
        "Firebase Cloud Messaging",
        "QR Scanner",
        "NodeJS Backend",
      ],
      features: [
        "Visitor pre-registration and dynamic entry pass QR keys",
        "Instant push alerts for resident confirmations at the gate",
        "Security automation with gate log registration",
        "Resident directory and manager announcement feed",
      ],
    ),
    Project(
      title: "Suraj Studio — AI Studio Management (Maxcore)",
      description:
          "AI-powered photography studio and event management ecosystem.",
      category: "Enterprise",
      imageUrl: "assets/projects/suraj.png",
      technologies: [
        "Flutter Web & Mobile",
        "Riverpod",
        "AWS S3",
        "Face Recognition API",
        "Stripe",
      ],
      features: [
        "Event booking and scheduling with deposit payments",
        "Automated QR-based event check-ins and photo logs",
        "AI-powered facial recognition to find your photos instantly",
        "Sleek photo galleries with download & print request pathways",
      ],
    ),
    Project(
      title: "ExtBuy/Sourcesin — MultiVendor eCommerce Platform (Almarai KSA)",
      description:
          "Large-scale multivendor eCommerce application developed for Almarai Company in Saudi Arabia, focused on scalable shopping experiences, vendor management, and seamless order workflows.",
      category: "Enterprise",
      imageUrl: "assets/projects/sourcesin.png",
      technologies: [
        "Flutter",
        "REST API",
        "Firebase",
        "Payment Gateway",
        "Google Maps",
        "State Management",
      ],
      features: [
        "Multi-vendor marketplace with dynamic product management",
        "Advanced cart, checkout, and secure payment workflows",
        "Live order tracking with delivery status updates",
        "Vendor dashboards with order and inventory management",
      ],
    ),
    Project(
      title: "Faster — Spain Delivery Ecosystem (Freelance)",
      description:
          "Large-scale delivery platform for stores, marts, and hotels with real-time tracking and booking systems. Freelance project.",
      category: "Enterprise",
      imageUrl: "assets/projects/faster.png",
      technologies: [
        "Flutter",
        "Google Maps SDK",
        "WebSocket",
        "Geolocator",
        "Background Tasks",
      ],
      features: [
        "Multi-vendor digital storefronts (stores, restaurants, hotels)",
        "Live delivery driver tracking on Google Maps via WebSocket",
        "Algorithmic driver matching & auto-dispatching",
        "Partner admin dashboards for order fulfillment",
      ],
    ),
  ];

  static const List<Map<String, dynamic>> technologies = [
    {"name": "Flutter", "icon": Icons.flutter_dash},
    {"name": "Dart", "icon": Icons.code},
    {"name": "Firebase", "icon": Icons.local_fire_department},
    {"name": "Supabase", "icon": Icons.cloud},
    {"name": "Riverpod", "icon": Icons.waves},
    {"name": "GoRouter", "icon": Icons.route},
    {"name": "Google Maps", "icon": Icons.map},
    {"name": "AI Integration", "icon": Icons.auto_awesome},
    {"name": "REST API", "icon": Icons.api},
    {"name": "QR Systems", "icon": Icons.qr_code_scanner},
    {"name": "WebSockets", "icon": Icons.sync_alt},
    {"name": "Git & CI/CD", "icon": Icons.terminal},
  ];

  // Contact Info & Links
  static const String email = "dev.mwaqas887@gmail.com";
  static const String github = "https://github.com/waqas8raza";
  static const String linkedin = "https://www.linkedin.com/in/muhammad-waqas-154840347?utm_source=share_via&utm_content=profile&utm_medium=member_android";
  static const String whatsapp = "https://wa.me/923492286687"; // standard format
}
