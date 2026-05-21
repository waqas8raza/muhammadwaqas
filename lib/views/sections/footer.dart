import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/hover_item.dart';

class Footer extends ConsumerWidget {
  const Footer({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 760;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white10, width: 1)),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Brand and Copyright
                Column(
                  crossAxisAlignment: isDesktop
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryEmerald.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/me.jpeg",
                              width: 14,
                              height: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            text: "Waqas",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: -0.5,
                                  color: Colors.white,
                                ),
                            children: const [
                              TextSpan(
                                text: ".",
                                style: TextStyle(
                                  color: AppTheme.accentEmerald,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "© ${DateTime.now().year} Muhammad Waqas. All rights reserved.",
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                if (!isDesktop) const SizedBox(height: 24),

                // Back to Top and social buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFooterSocialButton(
                      icon: Icons.code,
                      tooltip: "GitHub",
                      url: PortfolioData.github,
                    ),
                    const SizedBox(width: 12),
                    _buildFooterSocialButton(
                      icon: Icons.chat_bubble_outline_rounded,
                      tooltip: "LinkedIn",
                      url: PortfolioData.linkedin,
                    ),
                    const SizedBox(width: 12),
                    _buildFooterSocialButton(
                      icon: Icons.phone_android,
                      tooltip: "WhatsApp",
                      url: PortfolioData.whatsapp,
                    ),
                    const SizedBox(width: 24),
                    // Back to Top Button
                    HoverItem(
                      scale: 1.1,
                      builder: (context, isHovered) =>
                          FloatingActionButton.small(
                            onPressed: () {
                              ref
                                  .read(scrollNotifierProvider)
                                  .scrollToSection('Home');
                              ref.read(activeSectionProvider.notifier).state =
                                  'Home';
                            },
                            backgroundColor: isHovered
                                ? AppTheme.primaryEmerald
                                : Colors.white.withOpacity(0.04),
                            foregroundColor: isHovered
                                ? Colors.white
                                : Colors.white60,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: isHovered
                                    ? AppTheme.accentEmerald.withOpacity(0.3)
                                    : Colors.white.withOpacity(0.08),
                              ),
                            ),
                            elevation: 0,
                            child: const Icon(
                              Icons.arrow_upward_rounded,
                              size: 18,
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterSocialButton({
    required IconData icon,
    required String tooltip,
    required String url,
  }) {
    return HoverItem(
      scale: 1.1,
      builder: (context, isHovered) => IconButton(
        onPressed: () => _launchUrl(url),
        tooltip: tooltip,
        icon: Icon(
          icon,
          size: 18,
          color: isHovered ? AppTheme.accentEmerald : Colors.white60,
        ),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.02),
          padding: const EdgeInsets.all(10),
          side: BorderSide(
            color: isHovered
                ? AppTheme.primaryEmerald.withOpacity(0.3)
                : Colors.white.withOpacity(0.05),
          ),
        ),
      ),
    );
  }
}
