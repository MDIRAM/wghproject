import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onOpenArticle,
    required this.onOpenSettings,
    required this.onReviewsSelected,
    required this.onSelectTab,
    required this.selectedTab,
  });

  final VoidCallback onOpenArticle;
  final VoidCallback onOpenSettings;
  final VoidCallback onReviewsSelected;
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
            _Header(onOpenSettings: onOpenSettings),
            Divider(height: 1, color: AppTheme.borderFor(context)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                children: [
                  _FeedFilters(onReviewsSelected: onReviewsSelected),
                  SizedBox(height: 19),
                  Text(
                    'Your next adventure.',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  SizedBox(height: 16),
                  _FeedCard(
                    image: 'assets/images/elden_ring_guide.png',
                    category: 'ELDEN RING · BAB 1',
                    title: 'Limgrave Barat: Awal Perjalanan',
                    metadata: 'Walkthrough Game Hub · 12 Juli 2026',
                    onTap: onOpenArticle,
                  ),
                  const SizedBox(height: 16),
                  const _FeedCard(
                    image: 'assets/images/persona3_reload.png',
                    category: 'Persona 3 Reload',
                    title: 'How To Unlock Joker Boss Fight',
                    metadata: 'Panduan utama · Berlangsung',
                  ),
                  const SizedBox(height: 16),
                  const _FeedCard(
                    image: 'assets/images/persona4_golden.png',
                    category: 'Persona 4 Golden',
                    title: 'How To Beat Izanami',
                    metadata: 'Panduan utama · Berlangsung',
                  ),
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

class _Header extends StatelessWidget {
  const _Header({required this.onOpenSettings});

  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 63,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              'WGH',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkBlue
                    : AppTheme.blue,
                fontSize: 27,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const Spacer(),
            IconButton(
              key: const Key('homeSettingsButton'),
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

class _FeedFilters extends StatelessWidget {
  const _FeedFilters({
    required this.onReviewsSelected,
    this.onGamesSelected,
    this.reviewsSelected = false,
  });

  final VoidCallback onReviewsSelected;
  final VoidCallback? onGamesSelected;
  final bool reviewsSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterChip(
          label: 'GAMES',
          selected: !reviewsSelected,
          onTap: onGamesSelected,
        ),
        const SizedBox(width: 8),
        _FilterChip(
          label: 'REVIEWS',
          selected: reviewsSelected,
          onTap: onReviewsSelected,
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: selected
                ? (Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.darkBlue
                      : AppTheme.blue)
                : (Theme.of(context).brightness == Brightness.dark
                      ? AppTheme.darkRaised
                      : const Color(0xFFF3F5F8)),
            border: Border.all(
              color: selected
                  ? (Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkSurface
                        : AppTheme.blue)
                  : AppTheme.borderFor(context),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected
                  ? (Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkSurface
                        : Colors.white)
                  : AppTheme.mutedFor(context),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    super.key,
    required this.onGamesSelected,
    required this.onOpenSettings,
    required this.onOpenReview,
    required this.onSelectTab,
    required this.selectedTab,
  });

  final VoidCallback onGamesSelected;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenReview;
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
            _Header(onOpenSettings: onOpenSettings),
            Divider(height: 1, color: AppTheme.borderFor(context)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                children: [
                  _FeedFilters(
                    onReviewsSelected: _noop,
                    onGamesSelected: onGamesSelected,
                    reviewsSelected: true,
                  ),
                  SizedBox(height: 19),
                  Text(
                    'Reviews.',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Catatan bermain dan penilaian dari WGH.',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Contoh ulasan · Isi dan skor sementara',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(height: 17),
                  _ReviewCard(
                    score: '5',
                    category: 'ELDEN RING · REVIEW',
                    title: 'Elden Ring Review',
                    summary: 'Pertarungan, eksplorasi, dan alasan di balik penilaian WGH.',
                    image: 'assets/images/elden_ring_guide.png',
                    onTap: onOpenReview,
                  ),
                  SizedBox(height: 16),
                  _ReviewCard(
                    score: '4',
                    category: 'SEKIRO · REVIEW',
                    title: 'Sekiro Review',
                    summary: 'Ritme duel, tantangan, dan catatan pengalaman bermain WGH.',
                    image: 'assets/images/sekiro_review.png',
                    onTap: onOpenReview,
                  ),
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

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.score,
    required this.category,
    required this.title,
    required this.summary,
    required this.image,
    required this.onTap,
  });

  final String score;
  final String category;
  final String title;
  final String summary;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('openReview-$title'),
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
            Stack(
              children: [
                Image.asset(
                  image,
                  key: Key('reviewImage-$title'),
                  width: double.infinity,
                  height: 166,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 11,
                  right: 11,
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkBlue
                          : AppTheme.blue,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      score,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppTheme.darkSurface
                            : Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category, style: _feedEyebrowStyle(context)),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    summary,
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    'Oleh WGH · Contoh ulasan',
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

TextStyle _feedEyebrowStyle(BuildContext context) => TextStyle(
  color: Theme.of(context).brightness == Brightness.dark
      ? AppTheme.darkBlue
      : AppTheme.blue,
  fontSize: 11,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.8,
);

void _noop() {}

class _FeedCard extends StatelessWidget {
  const _FeedCard({
    required this.image,
    required this.category,
    required this.title,
    required this.metadata,
    this.onTap,
  });

  final String image;
  final String category;
  final String title;
  final String metadata;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      key: onTap == null ? null : const Key('openArticle'),
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
            SizedBox(
              height: 166,
              width: double.infinity,
              child: Image.asset(
                image,
                key: Key('feedImage-$title'),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkBlue
                          : AppTheme.blue,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    metadata,
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

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.selectedTab,
    required this.onSelectTab,
  });

  final int selectedTab;
  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 66,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: AppTheme.borderFor(context))),
        ),
        child: Row(
          children: [
            _NavigationItem(
              icon: Icons.home_outlined,
              label: 'Beranda',
              selected: selectedTab == 0,
              onTap: () => onSelectTab(0),
            ),
            _NavigationItem(
              icon: Icons.search,
              label: 'Search',
              selected: selectedTab == 1,
              onTap: () => onSelectTab(1),
            ),
            _NavigationItem(
              icon: Icons.person_outline,
              label: 'Profile',
              selected: selectedTab == 2,
              onTap: () => onSelectTab(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? (Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkBlue
              : AppTheme.blue)
        : AppTheme.mutedFor(context);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
