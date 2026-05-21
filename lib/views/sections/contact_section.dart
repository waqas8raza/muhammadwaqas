import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/hover_item.dart';

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

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ref.read(contactFormSubmittingProvider.notifier).state = true;
      ref.read(contactFormSuccessProvider.notifier).state = null;

      // Mock API call
      await Future.delayed(const Duration(seconds: 2));

      ref.read(contactFormSubmittingProvider.notifier).state = false;
      ref.read(contactFormSuccessProvider.notifier).state = true;

      // Clear controllers
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 960;
    final isMobile = screenWidth < 600;

    final isSubmitting = ref.watch(contactFormSubmittingProvider);
    final isSuccess = ref.watch(contactFormSuccessProvider);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 64 : 24,
            vertical: 80,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 2,
                    color: AppTheme.accentEmerald,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "CONTACT",
                    style: TextStyle(
                      color: AppTheme.accentEmerald,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "Get In Touch",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 48),

              // Layout grid
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side contact info cards
                  Expanded(
                    flex: isDesktop ? 5 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Let's discuss a project or opportunity",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "I am always open to discussing new mobile app ventures, scalable architectures, system integrations, or full-time opportunities. Drop me a line!",
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Email Link Card
                        _buildContactCard(
                          icon: Icons.email_rounded,
                          title: "Email Me At",
                          value: PortfolioData.email,
                          onTap: () => _launchUrl("mailto:${PortfolioData.email}"),
                        ),
                        const SizedBox(height: 16),

                        // WhatsApp Chat Link Card
                        _buildContactCard(
                          icon: Icons.chat_rounded,
                          title: "Chat on WhatsApp",
                          value: "+92 3492286687",
                          onTap: () => _launchUrl(PortfolioData.whatsapp),
                        ),
                      ],
                    ),
                  ),

                  if (isDesktop) const SizedBox(width: 48) else const SizedBox(height: 40),

                  // Right side contact form
                  Expanded(
                    flex: isDesktop ? 6 : 0,
                    child: GlassContainer(
                      padding: const EdgeInsets.all(32),
                      borderRadius: BorderRadius.circular(24),
                      opacity: 0.08,
                      borderColor: isSuccess == true
                          ? AppTheme.accentEmerald.withOpacity(0.3)
                          : Colors.white.withOpacity(0.08),
                      child: isSuccess == true
                          ? _buildSuccessPlaceholder()
                          : Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Name Field
                                  TextFormField(
                                    controller: _nameController,
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                      hintText: "Your Name",
                                      prefixIcon: Icon(Icons.person_outline, size: 20),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return "Please enter your name";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Email Field
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      hintText: "Your Email Address",
                                      prefixIcon: Icon(Icons.mail_outline, size: 20),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return "Please enter your email";
                                      }
                                      final emailRegex = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                      if (!emailRegex.hasMatch(val)) {
                                        return "Please enter a valid email address";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Message Field
                                  TextFormField(
                                    controller: _messageController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                      hintText: "Your Message...",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.only(bottom: 80),
                                        child: Icon(Icons.chat_bubble_outline_rounded, size: 20),
                                      ),
                                    ),
                                    validator: (val) {
                                      if (val == null || val.trim().isEmpty) {
                                        return "Please enter a message";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 24),

                                  // Submit Button
                                  HoverItem(
                                    scale: 1.02,
                                    builder: (context, isHovered) => ElevatedButton(
                                      onPressed: isSubmitting ? null : _submitForm,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.primaryEmerald,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: isSubmitting
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Send Message",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(Icons.send_rounded, size: 18),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return HoverItem(
      scale: 1.02,
      builder: (context, isHovered) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: GlassContainer(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(20),
          opacity: isHovered ? 0.12 : 0.06,
          borderColor: isHovered
              ? AppTheme.accentEmerald.withOpacity(0.3)
              : Colors.white.withOpacity(0.08),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryEmerald.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppTheme.accentEmerald,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isHovered ? AppTheme.accentEmerald : Colors.white24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppTheme.primaryEmerald,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.glowEmerald,
                blurRadius: 24,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.white,
            size: 48,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Message Sent!",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Thank you for reaching out. I'll get back to you as soon as possible.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        OutlinedButton(
          onPressed: () {
            ref.read(contactFormSuccessProvider.notifier).state = null;
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white24),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Send Another Message"),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
