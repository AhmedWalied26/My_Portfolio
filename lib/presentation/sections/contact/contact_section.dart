import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/emailjs_service.dart';
import '../../../core/utils/download_helper.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../widgets/animated_reveal.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/modern_button.dart';
import '../../widgets/responsive_layout.dart';
import '../../widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const SectionTitle(
                tag: 'Connect',
                title: AppStrings.contactTitle,
                subtitle: AppStrings.contactSubtitle,
              ),
              isDesktop
                  ? _buildDesktopLayout(context)
                  : _buildMobileLayout(context),
              const SizedBox(height: 48),
              _buildDownloadCvBanner(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: AnimatedReveal(
            child: const _ContactForm(),
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 4,
          child: _buildQuickContactCards(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        AnimatedReveal(
          child: const _ContactForm(),
        ),
        const SizedBox(height: 32),
        _buildQuickContactCards(context),
      ],
    );
  }

  Widget _buildQuickContactCards(BuildContext context) {
    final contactItems = [
      _ContactItemData(
        title: 'Email Address',
        value: AppStrings.email,
        actionLabel: 'Send Direct Email',
        icon: Icons.email_rounded,
        color: AppColors.primary,
        onTap: () => UrlHelper.launchEmail(AppStrings.email),
      ),
      _ContactItemData(
        title: 'Phone Call',
        value: AppStrings.phone,
        actionLabel: 'Call Now',
        icon: Icons.phone_in_talk_rounded,
        color: AppColors.secondary,
        onTap: () => UrlHelper.launchPhone(AppStrings.phone),
      ),
      _ContactItemData(
        title: 'WhatsApp',
        value: AppStrings.phoneInternational,
        actionLabel: 'Chat on WhatsApp',
        icon: Icons.chat_bubble_outline_rounded,
        color: AppColors.accentGreen,
        onTap: () => UrlHelper.launchWhatsApp(AppStrings.phoneInternational),
      ),
      _ContactItemData(
        title: 'LinkedIn',
        value: AppStrings.linkedinUsername,
        actionLabel: 'Connect on LinkedIn',
        icon: Icons.business_center_rounded,
        color: AppColors.secondary,
        onTap: () => UrlHelper.launchURL(AppStrings.linkedinUrl),
      ),
      _ContactItemData(
        title: 'GitHub',
        value: AppStrings.githubUsername,
        actionLabel: 'Explore Repositories',
        icon: Icons.code_rounded,
        color: AppColors.accentPurple,
        onTap: () => UrlHelper.launchURL(AppStrings.githubUrl),
      ),
    ];

    return Column(
      children: contactItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AnimatedReveal(
            delay: Duration(milliseconds: 70 * index),
            child: _buildContactCard(item),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactCard(_ContactItemData item) {
    return GlassCard(
      hoverBorderColor: item.color.withOpacity(0.6),
      onTap: item.onTap,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: item.color.withOpacity(0.3),
              ),
            ),
            child: Icon(item.icon, size: 20, color: item.color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_rounded,
            size: 16,
            color: item.color.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadCvBanner(BuildContext context) {
    return AnimatedReveal(
      delay: const Duration(milliseconds: 300),
      child: GlassCard(
        backgroundColor: AppColors.surfaceVariant.withOpacity(0.6),
        hoverBorderColor: AppColors.primary.withOpacity(0.6),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: ResponsiveLayout(
          mobile: Column(
            children: [
              const Icon(
                Icons.description_rounded,
                size: 44,
                color: AppColors.primary,
              ),
              const SizedBox(height: 14),
              Text(
                'Looking for a complete resume?',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Download the official CV directly to review full project architecture details and credentials.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              ModernButton(
                text: 'Download CV',
                icon: Icons.download_rounded,
                variant: ModernButtonVariant.primaryGradient,
                isGlowing: true,
                onTap: () => downloadCv(),
              ),
            ],
          ),
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: const Icon(
                      Icons.description_rounded,
                      size: 32,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Looking for a complete resume?',
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Download the official CV directly to review full project architecture details and credentials.',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ModernButton(
                text: 'Download CV',
                icon: Icons.download_rounded,
                variant: ModernButtonVariant.primaryGradient,
                isGlowing: true,
                onTap: () => downloadCv(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _isSuccess = false;
  String? _resultMessage;

  late final AnimationController _successAnimController;
  late final Animation<double> _successScaleAnim;

  @override
  void initState() {
    super.initState();
    _successAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _successScaleAnim = CurvedAnimation(
      parent: _successAnimController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _successAnimController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
      _resultMessage = null;
      _isSuccess = false;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();
    final message = _messageController.text.trim();

    final result = await EmailJsService.sendEmail(
      name: name,
      email: email,
      subject: subject,
      message: message,
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
      _isSuccess = result.success;
      _resultMessage = result.message;
    });

    if (result.success) {
      _successAnimController.forward(from: 0);
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();

      Future.delayed(const Duration(seconds: 6), () {
        if (mounted) {
          setState(() {
            _resultMessage = null;
            _isSuccess = false;
          });
        }
      });
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a subject';
    }
    if (value.trim().length < 3) {
      return 'Subject must be at least 3 characters';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your message';
    }
    if (value.trim().length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      enableHover: false,
      padding: const EdgeInsets.all(28),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Send Me a Message',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Messages are sent directly to ${AppStrings.email}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: AppColors.border),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 500) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildFormField(
                          controller: _nameController,
                          label: 'Full Name',
                          hint: 'Your name',
                          icon: Icons.person_outline_rounded,
                          validator: _validateName,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildFormField(
                          controller: _emailController,
                          label: 'Email Address',
                          hint: 'your.email@example.com',
                          icon: Icons.email_outlined,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    _buildFormField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'Your name',
                      icon: Icons.person_outline_rounded,
                      validator: _validateName,
                    ),
                    const SizedBox(height: 16),
                    _buildFormField(
                      controller: _emailController,
                      label: 'Email Address',
                      hint: 'your.email@example.com',
                      icon: Icons.email_outlined,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _subjectController,
              label: 'Subject',
              hint: 'Project Inquiry / Job Opportunity',
              icon: Icons.subject_rounded,
              validator: _validateSubject,
            ),
            const SizedBox(height: 16),
            _buildFormField(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell me about your project or inquiry...',
              icon: Icons.message_outlined,
              validator: _validateMessage,
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            if (_resultMessage != null)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: _isSuccess
                      ? AppColors.accentGreen.withOpacity(0.1)
                      : Colors.redAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isSuccess
                        ? AppColors.accentGreen.withOpacity(0.4)
                        : Colors.redAccent.withOpacity(0.4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ScaleTransition(
                          scale: _isSuccess
                              ? _successScaleAnim
                              : const AlwaysStoppedAnimation(1.0),
                          child: Icon(
                            _isSuccess
                                ? Icons.check_circle_rounded
                                : Icons.error_outline_rounded,
                            color: _isSuccess
                                ? AppColors.accentGreen
                                : Colors.redAccent,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _resultMessage!,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _isSuccess
                                  ? AppColors.accentGreen
                                  : Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!_isSuccess) ...[
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () => UrlHelper.launchEmail(
                          AppStrings.email,
                          subject: _subjectController.text.trim(),
                          body: _messageController.text.trim(),
                        ),
                        child: Text(
                          'Click here to send directly via your email client →',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: _isSubmitting
                  ? Center(
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Sending...',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ModernButton(
                      text: 'Send Message',
                      icon: Icons.send_rounded,
                      width: double.infinity,
                      variant: ModernButtonVariant.primaryGradient,
                      isGlowing: true,
                      onTap: _handleSubmit,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppColors.textMuted),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textMuted.withOpacity(0.5),
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant.withOpacity(0.4),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.redAccent.withOpacity(0.6),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.redAccent,
                width: 1.5,
              ),
            ),
            errorStyle: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.redAccent,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactItemData {
  final String title;
  final String value;
  final String actionLabel;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ContactItemData({
    required this.title,
    required this.value,
    required this.actionLabel,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
