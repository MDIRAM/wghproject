import 'package:flutter/material.dart';

import 'screens/article_screen.dart';
import 'screens/comments_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/review_article_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/onboarding_sheet.dart';

class WghApp extends StatefulWidget {
  const WghApp({super.key});

  @override
  State<WghApp> createState() => _WghAppState();
}

class _WghAppState extends State<WghApp> {
  bool _showOnboarding = true;
  bool _isMember = false;
  bool _isBookmarked = false;
  bool _isDark = false;
  final List<String> _comments = ['bagus'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Builder(
        builder: (context) => Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: _AppShell(
                  isMember: _isMember,
                  isBookmarked: _isBookmarked,
                  onSignIn: _signIn,
                  onOpenSettings: () => _openSettings(context),
                  onOpenArticle: () => _openArticle(context),
                  onOpenReview: () => _openReview(context),
                ),
              ),
              if (_showOnboarding) ...[
                const Positioned.fill(
                  child: ColoredBox(color: Color(0x800B1220)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: OnboardingSheet(
                    onStayLoggedOut: () {
                      setState(() => _showOnboarding = false);
                    },
                    onSignIn: _signIn,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() {
    setState(() {
      _isMember = true;
      _showOnboarding = false;
    });
  }

  void _openArticle(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ArticleScreen(
          isBookmarked: _isBookmarked,
          onToggleBookmark: () {
            setState(() => _isBookmarked = !_isBookmarked);
          },
          onOpenComments: () => _openComments(context),
        ),
      ),
    );
  }

  void _openReview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) =>
            ReviewArticleScreen(onOpenComments: () => _openComments(context)),
      ),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SettingsScreen(
          isMember: _isMember,
          isDark: _isDark,
          onSignIn: () {
            _signIn();
            Navigator.of(context).pop();
          },
          onSignOut: () {
            setState(() {
              _isMember = false;
              _isBookmarked = false;
            });
            Navigator.of(context).pop();
          },
          onThemeChanged: (isDark) {
            setState(() => _isDark = isDark);
          },
        ),
      ),
    );
  }

  void _openComments(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => CommentsScreen(
          isMember: _isMember,
          comments: _comments,
          onSignIn: _signIn,
          onPostComment: (comment) {
            setState(() => _comments.insert(0, comment));
          },
        ),
      ),
    );
  }
}

class _AppShell extends StatefulWidget {
  const _AppShell({
    required this.isMember,
    required this.isBookmarked,
    required this.onSignIn,
    required this.onOpenSettings,
    required this.onOpenArticle,
    required this.onOpenReview,
  });

  final bool isMember;
  final bool isBookmarked;
  final VoidCallback onSignIn;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenArticle;
  final VoidCallback onOpenReview;

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _selectedTab = 0;
  bool _showReviews = false;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _selectedTab,
      children: [
        _showReviews
            ? ReviewScreen(
                onGamesSelected: () => setState(() => _showReviews = false),
                onOpenSettings: widget.onOpenSettings,
                onOpenReview: widget.onOpenReview,
                onSelectTab: _selectTab,
                selectedTab: _selectedTab,
              )
            : HomeScreen(
                onOpenArticle: widget.onOpenArticle,
                onOpenSettings: widget.onOpenSettings,
                onReviewsSelected: () => setState(() => _showReviews = true),
                onSelectTab: _selectTab,
                selectedTab: _selectedTab,
              ),
        SearchScreen(
          onOpenArticle: widget.onOpenArticle,
          onSelectTab: _selectTab,
          selectedTab: _selectedTab,
        ),
        ProfileScreen(
          isMember: widget.isMember,
          isBookmarked: widget.isBookmarked,
          onSignIn: widget.onSignIn,
          onOpenSettings: widget.onOpenSettings,
          onOpenArticle: widget.onOpenArticle,
          onSelectTab: _selectTab,
          selectedTab: _selectedTab,
        ),
      ],
    );
  }

  void _selectTab(int index) {
    setState(() => _selectedTab = index);
  }
}
