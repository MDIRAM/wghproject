import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.onOpenArticle,
    required this.onSelectTab,
    required this.selectedTab,
  });

  final VoidCallback onOpenArticle;
  final ValueChanged<int> onSelectTab;
  final int selectedTab;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  static const _guides = [
    ('ELDEN RING · BAB 1', 'Limgrave Barat: Awal Perjalanan'),
    ('ELDEN RING · BAB 2', 'Limgrave Timur: Mistwood dan Fort Haight'),
    ('ELDEN RING · BAB 3', 'Stormveil Castle: Margit dan Godrick'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final normalizedQuery = _query.trim().toLowerCase();
    final matches = normalizedQuery.isEmpty
        ? const <(String, String)>[]
        : _guides
              .where(
                (guide) =>
                    guide.$1.toLowerCase().contains(normalizedQuery) ||
                    guide.$2.toLowerCase().contains(normalizedQuery),
              )
              .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  TextField(
                    key: const Key('searchField'),
                    controller: _controller,
                    onChanged: (value) => setState(() => _query = value),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search by game title',
                      hintStyle: TextStyle(color: AppTheme.mutedFor(context)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.mutedFor(context),
                      ),
                      suffixIcon: _query.isEmpty
                          ? null
                          : IconButton(
                              key: const Key('clearSearch'),
                              tooltip: 'Clear search',
                              onPressed: () {
                                _controller.clear();
                                setState(() => _query = '');
                              },
                              icon: Icon(
                                Icons.close,
                                color: AppTheme.mutedFor(context),
                              ),
                            ),
                      filled: true,
                      fillColor: Theme.of(context).brightness == Brightness.dark
                          ? AppTheme.darkRaised
                          : const Color(0xFFF3F5F8),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppTheme.borderFor(context),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppTheme.borderFor(context),
                        ),
                      ),
                    ),
                  ),
                  if (normalizedQuery.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      matches.isEmpty
                          ? 'No matching guides.'
                          : '${matches.length} matching guides · Elden Ring',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    for (var index = 0; index < matches.length; index++)
                      _SearchResult(
                        category: matches[index].$1,
                        title: matches[index].$2,
                        onTap: widget.onOpenArticle,
                      ),
                    const SizedBox(height: 22),
                    Text(
                      'Search by game title.',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 12,
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 20),
                    Text(
                      'Search by game title.',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 12,
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
        selectedTab: widget.selectedTab,
        onSelectTab: widget.onSelectTab,
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({
    required this.category,
    required this.title,
    required this.onTap,
  });

  final String category;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key('searchResult-$category'),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 19),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppTheme.borderFor(context)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                'assets/images/elden_ring_guide.png',
                width: 96,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
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
                    const SizedBox(height: 7),
                    Text(
                      title,
                      style: TextStyle(
                        color: AppTheme.inkFor(context),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Panduan utama · Berlangsung',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
