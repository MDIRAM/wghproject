import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.isMember,
    required this.isBookmarked,
    required this.onSignIn,
    required this.onOpenArticle,
    required this.onOpenSettings,
    required this.onSelectTab,
    required this.selectedTab,
  });

  final bool isMember;
  final bool isBookmarked;
  final VoidCallback onSignIn;
  final VoidCallback onOpenArticle;
  final VoidCallback onOpenSettings;
  final ValueChanged<int> onSelectTab;
  final int selectedTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _ProfileHeader(onOpenSettings: onOpenSettings),
            Divider(height: 1, color: AppTheme.borderFor(context)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                children: [
                  _AccountSummary(isMember: isMember),
                  const SizedBox(height: 25),
                  Divider(height: 1, color: AppTheme.borderFor(context)),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Text(
                        'My Bookmarks',
                        style: TextStyle(
                          color: AppTheme.inkFor(context),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Spacer(),
                      if (isMember && isBookmarked)
                        Text(
                          '1 saved',
                          style: TextStyle(
                            color: AppTheme.mutedFor(context),
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (isMember && isBookmarked)
                    _SavedArticleCard(onTap: onOpenArticle)
                  else
                    _EmptyBookmarks(isMember: isMember, onSignIn: onSignIn),
                  if (isMember && isBookmarked) ...[
                    const SizedBox(height: 28),
                    Text(
                      'Semua panduan tersimpan ada di My Bookmarks.',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        selectedTab: selectedTab,
        onSelectTab: onSelectTab,
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onOpenSettings});

  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              'PROFILE',
              style: TextStyle(
                color: AppTheme.inkFor(context),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            IconButton(
              key: const Key('profileSettingsButton'),
              onPressed: onOpenSettings,
              tooltip: 'Settings',
              icon: Icon(
                Icons.settings_outlined,
                color: AppTheme.inkFor(context),
                size: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountSummary extends StatelessWidget {
  const _AccountSummary({required this.isMember});

  final bool isMember;

  @override
  Widget build(BuildContext context) {
    if (!isMember) {
      return Row(
        children: [
          _ProfileAvatar(isMember: false),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Browsing as Guest',
                style: TextStyle(
                  color: AppTheme.inkFor(context),
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'You are logged out',
                style: TextStyle(
                  color: AppTheme.mutedFor(context),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        _ProfileAvatar(isMember: true),
        SizedBox(width: 16),
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

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.isMember});

  final bool isMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkRaised
            : const Color(0xFFEDF3FF),
        shape: BoxShape.circle,
      ),
      child: isMember
          ? Text(
              'L',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkBlue
                    : AppTheme.blue,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            )
          : Icon(
              Icons.person_outline,
              color: AppTheme.mutedFor(context),
              size: 27,
            ),
    );
  }
}

class _EmptyBookmarks extends StatelessWidget {
  const _EmptyBookmarks({required this.isMember, required this.onSignIn});

  final bool isMember;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkRaised
            : const Color(0xFFF3F5F8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkSurface
                  : const Color(0xFFEDF3FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bookmark_border,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkBlue
                  : AppTheme.blue,
              size: 27,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            isMember ? 'No bookmarks yet.' : 'Keep your place.',
            style: TextStyle(
              color: AppTheme.inkFor(context),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            isMember ? 'Simpan panduan favorit untuk melihatnya di sini.' : 'Masuk dengan Google untuk menyimpan panduan dan melihat My Bookmarks Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.mutedFor(context),
              fontSize: 14,
              height: 1.55,
            ),
          ),
          if (!isMember) ...[
            const SizedBox(height: 18),
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
            const SizedBox(height: 17),
            Text(
              'Tetap bisa membaca tanpa login.',
              style: TextStyle(color: AppTheme.mutedFor(context), fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

class _SavedArticleCard extends StatelessWidget {
  const _SavedArticleCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('savedArticle'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppTheme.raisedFor(context),
          border: Border.all(color: AppTheme.borderFor(context)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/elden_ring_guide.png',
              height: 166,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'ELDEN RING · BAB 1',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppTheme.darkBlue
                              : AppTheme.blue,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.bookmark,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.darkBlue
                            : AppTheme.blue,
                        size: 19,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Limgrave Barat: Awal Perjalanan',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 20,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    'Saved to My Bookmarks',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 11,
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
