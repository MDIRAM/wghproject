import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({
    super.key,
    required this.isBookmarked,
    required this.onToggleBookmark,
    required this.onOpenComments,
  });

  final bool isBookmarked;
  final VoidCallback onToggleBookmark;
  final VoidCallback onOpenComments;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late bool _isBookmarked = widget.isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            _ArticleHeader(
              isBookmarked: _isBookmarked,
              onToggleBookmark: _toggleBookmark,
            ),
            Divider(height: 1, color: AppTheme.borderFor(context)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 20),
                children: [
                  Text(
                    'ELDEN RING / PANDUAN UTAMA / BAB 1',
                    style: _eyebrowStyle(context),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    'Limgrave Barat: Awal Perjalanan',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 30,
                      height: 1.12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Oleh Walkthrough Game Hub',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Diperbarui 12 Juli 2026',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      'assets/images/elden_ring_article.png',
                      height: 194,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Elden Ring · The Lands Between',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Menuju Church of Elleh',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Dari The First Step, ikuti cahaya penunjuk Grace ke arah utara. Lewati Tree Sentinel dan masuk ke reruntuhan Church of Elleh.',
                    style: _bodyStyle(context),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Aktifkan Site of Grace, lalu temui Merchant Kalé. Beli Crafting Kit untuk mulai membuat item sebelum melanjutkan perjalanan.',
                    style: _bodyStyle(context),
                  ),
                  const SizedBox(height: 24),
                  _TravelTip(),
                  const SizedBox(height: 22),
                  Text(
                    'Langkah singkat',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _StepLine(
                    number: '1.',
                    text: 'Ikuti penunjuk Grace ke utara dari The First Step.',
                  ),
                  const _StepLine(
                    number: '2.',
                    text:
                        'Masuk ke Church of Elleh dan aktifkan Site of Grace.',
                  ),
                  const _StepLine(
                    number: '3.',
                    text: 'Temui Merchant Kalé, lalu beli Crafting Kit.',
                  ),
                  const SizedBox(height: 14),
                  Divider(color: AppTheme.borderFor(context)),
                  const SizedBox(height: 10),
                  Text('UP NEXT · BAB 2', style: _eyebrowStyle(context)),
                  const SizedBox(height: 8),
                  Text(
                    'Limgrave Timur: Mistwood dan Fort Haight',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 22),
                  OutlinedButton(
                    key: const Key('openComments'),
                    onPressed: widget.onOpenComments,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.inkFor(context),
                      minimumSize: const Size.fromHeight(50),
                      side: BorderSide(color: AppTheme.borderFor(context)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Show Comments',
                      style: TextStyle(fontWeight: FontWeight.w700),
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

  void _toggleBookmark() {
    widget.onToggleBookmark();
    setState(() => _isBookmarked = !_isBookmarked);
  }
}

class _ArticleHeader extends StatelessWidget {
  const _ArticleHeader({
    required this.isBookmarked,
    required this.onToggleBookmark,
  });

  final bool isBookmarked;
  final VoidCallback onToggleBookmark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Back',
            icon: Icon(Icons.arrow_back, color: AppTheme.inkFor(context)),
          ),
          Text(
            'WGH',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkBlue
                  : AppTheme.blue,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const Spacer(),
          IconButton(
            key: const Key('bookmarkButton'),
            onPressed: onToggleBookmark,
            tooltip: isBookmarked ? 'Remove bookmark' : 'Save bookmark',
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked
                  ? (Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkBlue
                        : AppTheme.blue)
                  : AppTheme.inkFor(context),
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'Share',
            icon: Icon(Icons.share_outlined, color: AppTheme.inkFor(context)),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _TravelTip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkRaised
            : const Color(0xFFEDF3FF),
        border: Border(
          left: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.darkBlue
                : AppTheme.blue,
            width: 3,
          ),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.darkBlue
                : AppTheme.blue,
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catatan perjalanan',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkBlue
                        : AppTheme.blue,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Lewati Tree Sentinel terlebih dahulu. Fokus pada Site of Grace dan Crafting Kit sebelum melanjutkan.',
                  style: TextStyle(
                    color: AppTheme.inkFor(context),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Text(
              number,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkBlue
                    : AppTheme.blue,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: Text(text, style: _bodyStyle(context))),
        ],
      ),
    );
  }
}

TextStyle _eyebrowStyle(BuildContext context) => TextStyle(
  color: Theme.of(context).brightness == Brightness.dark
      ? AppTheme.darkBlue
      : AppTheme.blue,
  fontSize: 11,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.8,
);

TextStyle _bodyStyle(BuildContext context) =>
    TextStyle(color: AppTheme.inkFor(context), fontSize: 16, height: 1.7);
