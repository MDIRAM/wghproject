import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.isMember,
    required this.isDark,
    required this.onSignIn,
    required this.onSignOut,
    required this.onThemeChanged,
  });

  final bool isMember;
  final bool isDark;
  final VoidCallback onSignIn;
  final VoidCallback onSignOut;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 62,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Back',
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppTheme.inkFor(context),
                    ),
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: AppTheme.borderFor(context)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 27, 24, 24),
                children: [
                  if (isMember) ...[
                    const _SectionLabel('Account'),
                    const SizedBox(height: 17),
                    const _MemberAccount(),
                    const SizedBox(height: 26),
                  ] else ...[
                    const _SectionLabel('Login'),
                    const SizedBox(height: 17),
                    Text(
                      'You are logged out',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: onSignIn,
                        icon: const Text(
                          'G',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        label: const Text(
                          'Continue with Google',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppTheme.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                  ],
                  Divider(height: 1, color: AppTheme.borderFor(context)),
                  const SizedBox(height: 26),
                  const _SectionLabel('App Preferences'),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.brightness_4_outlined,
                        color: AppTheme.inkFor(context),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Appearance',
                        style: TextStyle(
                          color: AppTheme.inkFor(context),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _AppearancePicker(
                    isDark: isDark,
                    onChanged: onThemeChanged,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Light is the default. Dark Mode is optional.',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Divider(height: 1, color: AppTheme.borderFor(context)),
                  const SizedBox(height: 26),
                  const _SectionLabel('Support & Legal'),
                  const SizedBox(height: 10),
                  const _LegalRow('Help & Support'),
                  const _LegalRow('Community Guidelines'),
                  const _LegalRow('Terms of Use'),
                  const _LegalRow('Privacy Policy'),
                  const SizedBox(height: 15),
                  if (isMember)
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        key: const Key('signOut'),
                        onPressed: onSignOut,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.inkFor(context),
                          side: BorderSide(
                            color: AppTheme.borderFor(context),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.darkRaised
                            : const Color(0xFFF3F5F8),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        'You are logged out',
                        style: TextStyle(
                          color: AppTheme.mutedFor(context),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  const SizedBox(height: 25),
                  Center(
                    child: Text(
                      'WGH · Walkthrough Game Hub',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberAccount extends StatelessWidget {
  const _MemberAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 27,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkRaised
              : const Color(0xFFEDF3FF),
          child: Text(
            'L',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkBlue
                  : AppTheme.blue,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'loki',
              style: TextStyle(
                color: AppTheme.inkFor(context),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'loki@example.com',
              style: TextStyle(color: AppTheme.mutedFor(context), fontSize: 13),
            ),
            SizedBox(height: 3),
            Text(
              'Demo account · loki',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkBlue
                    : AppTheme.blue,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AppearancePicker extends StatelessWidget {
  const _AppearancePicker({required this.isDark, required this.onChanged});

  final bool isDark;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkRaised
            : const Color(0xFFF3F5F8),
        border: Border.all(color: AppTheme.borderFor(context)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _AppearanceChoice(
            key: const Key('appearanceLight'),
            label: 'Light',
            icon: Icons.light_mode_outlined,
            selected: !isDark,
            onTap: () => onChanged(false),
          ),
          _AppearanceChoice(
            key: const Key('appearanceDark'),
            label: 'Dark',
            icon: Icons.dark_mode_outlined,
            selected: isDark,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }
}

class _AppearanceChoice extends StatelessWidget {
  const _AppearanceChoice({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          decoration: selected
              ? BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkBlue
                          : AppTheme.blue,
                      width: 1.5,
                    ),
                  borderRadius: BorderRadius.circular(9),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected
                    ? (Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkBlue
                          : AppTheme.blue)
                    : AppTheme.mutedFor(context),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: selected
                      ? (Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.darkBlue
                            : AppTheme.blue)
                      : AppTheme.mutedFor(context),
                  fontSize: 13,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              if (selected) ...[
                const SizedBox(width: 6),
                Icon(
                  Icons.check,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.darkBlue
                      : AppTheme.blue,
                  size: 16,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: AppTheme.mutedFor(context),
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _LegalRow extends StatelessWidget {
  const _LegalRow(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.inkFor(context),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right,
            color: AppTheme.mutedFor(context),
          ),
        ],
      ),
    );
  }
}
