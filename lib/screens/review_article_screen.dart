import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ReviewArticleScreen extends StatefulWidget {
  const ReviewArticleScreen({super.key, required this.onOpenComments});

  final VoidCallback onOpenComments;

  @override
  State<ReviewArticleScreen> createState() => _ReviewArticleScreenState();
}

class _ReviewArticleScreenState extends State<ReviewArticleScreen> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final ink = AppTheme.inkFor(context);
    final muted = AppTheme.mutedFor(context);

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
                    icon: Icon(Icons.arrow_back, color: ink),
                  ),
                  const Text(
                    'WGH',
                    style: TextStyle(
                      color: AppTheme.blue,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    key: const Key('reviewBookmark'),
                    onPressed: () =>
                        setState(() => _isBookmarked = !_isBookmarked),
                    tooltip: _isBookmarked ? 'Remove bookmark' : 'Save review',
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: _isBookmarked
                          ? (dark ? AppTheme.darkBlue : AppTheme.blue)
                          : ink,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    tooltip: 'Share',
                    icon: Icon(Icons.share_outlined, color: ink),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            Divider(height: 1, color: AppTheme.borderFor(context)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
                children: [
                  const _Eyebrow('ELDEN RING / REVIEW'),
                  const SizedBox(height: 11),
                  Text(
                    'Elden Ring Review',
                    style: TextStyle(
                      color: ink,
                      fontSize: 29,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Pertarungan, eksplorasi, dan alasan di balik penilaian WGH.',
                    style: TextStyle(color: muted, fontSize: 16, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Oleh WGH',
                    style: TextStyle(
                      color: ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Contoh ulasan · Naskah sementara',
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                  const SizedBox(height: 21),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Image.asset(
                      'assets/images/elden_ring_article.png',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Elden Ring · The Lands Between',
                    style: TextStyle(color: muted, fontSize: 11),
                  ),
                  const SizedBox(height: 21),
                  _BodyParagraph(
                    color: ink,
                    text: 'Ulasan ini akan merangkum pengalaman WGH bermain Elden Ring. Teks berikut adalah contoh yang dapat diedit, bukan ulasan final.',
                  ),
                  const SizedBox(height: 20),
                  _ReviewSection(
                    title: 'Gameplay',
                    paragraphs: const [
                      'Bagian ini akan menjelaskan pengalaman bermain: bagaimana kontrol, ritme pertarungan, dan pilihan build terasa saat digunakan.',
                      'Contoh bahasan: apakah tantangan terasa seimbang dengan proses belajar? Catatan tentang duel, kematian, dan percobaan ulang akan ditulis dari pengalaman WGH sendiri.',
                    ],
                    color: ink,
                  ),
                  _ReviewSection(
                    title: 'Dunia & eksplorasi',
                    paragraphs: const [
                      'Bagian ini akan membahas perjalanan di The Lands Between. Rute yang dipilih, penemuan tak terduga, dan dorongan untuk menjelajah akan menjadi fokus ulasan.',
                      'Contoh bahasan: kapan kebebasan menjelajah terasa menarik, dan kapan arah perjalanan terasa kurang jelas? Pengalaman konkretnya akan ditambahkan pada naskah akhir.',
                    ],
                    color: ink,
                  ),
                  _ReviewSection(
                    title: 'Alasan di balik penilaian',
                    paragraphs: const [
                      'Bagian ini akan menghubungkan catatan gameplay dan eksplorasi dengan penilaian akhir. Kelebihan serta hal yang mengurangi kenyamanan bermain akan dijelaskan secara terbuka.',
                      'Untuk contoh tampilan ini, skor yang digunakan adalah 5. Alasan pribadi WGH akan menggantikan teks sementara ini, agar pembaca memahami pertimbangan di balik angka tersebut.',
                    ],
                    color: ink,
                    showDivider: false,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
                    decoration: BoxDecoration(
                      color: dark
                          ? const Color(0xFF21314F)
                          : const Color(0xFFEDF3FF),
                      border: Border(
                        top: BorderSide(
                          color: dark ? AppTheme.darkBlue : AppTheme.blue,
                          width: 3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hasil Review',
                          style: TextStyle(
                            color: ink,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '5',
                          style: TextStyle(
                            color: dark ? AppTheme.darkBlue : AppTheme.blue,
                            fontSize: 74,
                            height: 1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Contoh ringkasan: hasil ini akan dijelaskan lewat pengalaman bertarung, menjelajah, serta hal yang mendukung dan mengurangi penilaian WGH.',
                          style: TextStyle(
                            color: ink,
                            fontSize: 14,
                            height: 1.55,
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          'Contoh ulasan · Skor dan alasan sementara',
                          style: TextStyle(color: muted, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  OutlinedButton(
                    key: const Key('openReviewComments'),
                    onPressed: widget.onOpenComments,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ink,
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
}

class _Eyebrow extends StatelessWidget {
  const _Eyebrow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkBlue
            : AppTheme.blue,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }
}

class _BodyParagraph extends StatelessWidget {
  const _BodyParagraph({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: TextStyle(color: color, fontSize: 16, height: 1.7));
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.title,
    required this.paragraphs,
    required this.color,
    this.showDivider = true,
  });

  final String title;
  final List<String> paragraphs;
  final Color color;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDivider) ...[
          const SizedBox(height: 19),
          Divider(height: 1, color: AppTheme.borderFor(context)),
          const SizedBox(height: 17),
        ],
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        for (final paragraph in paragraphs) ...[
          const SizedBox(height: 15),
          _BodyParagraph(color: color, text: paragraph),
        ],
      ],
    );
  }
}
