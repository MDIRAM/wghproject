import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    super.key,
    required this.isMember,
    required this.comments,
    required this.onSignIn,
    required this.onPostComment,
  });

  final bool isMember;
  final List<String> comments;
  final VoidCallback onSignIn;
  final ValueChanged<String> onPostComment;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late bool _isMember = widget.isMember;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _CommentsHeader(),
            Divider(height: 1, color: AppTheme.borderFor(context)),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 27, 24, 20),
                children: [
                  Text(
                    'ELDEN RING · BAB 1',
                    style: _eyebrowStyle(context),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Limgrave Barat: Awal Perjalanan',
                    style: TextStyle(
                      color: AppTheme.inkFor(context),
                      fontSize: 23,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Bagikan pengalamanmu. Jaga diskusi tetap ramah dan sesuai panduan.',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 13,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 23),
                  Divider(height: 1, color: AppTheme.borderFor(context)),
                  const SizedBox(height: 25),
                  if (_isMember)
                    _CommentComposer(
                      controller: _commentController,
                      onPost: _postComment,
                    )
                  else
                    _GuestPrompt(onSignIn: _signIn),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Text(
                        'Conversation',
                        style: TextStyle(
                          color: AppTheme.inkFor(context),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${widget.comments.length} comment${widget.comments.length == 1 ? '' : 's'}',
                        style: TextStyle(
                          color: AppTheme.mutedFor(context),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),
                  Divider(height: 1, color: AppTheme.borderFor(context)),
                  for (final comment in widget.comments)
                    _CommentItem(text: comment),
                  const SizedBox(height: 20),
                  Text(
                    'Anda sudah membaca semua komentar.',
                    style: TextStyle(
                      color: AppTheme.mutedFor(context),
                      fontSize: 12,
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

  void _signIn() {
    widget.onSignIn();
    setState(() => _isMember = true);
  }

  void _postComment() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) return;
    widget.onPostComment(comment);
    _commentController.clear();
    setState(() {});
  }
}

class _CommentsHeader extends StatelessWidget {
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
            'Comments',
            style: TextStyle(
              color: AppTheme.inkFor(context),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestPrompt extends StatelessWidget {
  const _GuestPrompt({required this.onSignIn});

  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkRaised
            : const Color(0xFFF3F5F8),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lock_outline,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkBlue
                    : AppTheme.blue,
                size: 20,
              ),
              SizedBox(width: 10),
              Text(
                'Log in to comment',
                style: TextStyle(
                  color: AppTheme.inkFor(context),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Guest dapat membaca komentar. Masuk dengan Google untuk menulis komentar.',
            style: TextStyle(
              color: AppTheme.mutedFor(context),
              fontSize: 13,
              height: 1.5,
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
        ],
      ),
    );
  }
}

class _CommentComposer extends StatelessWidget {
  const _CommentComposer({required this.controller, required this.onPost});

  final TextEditingController controller;
  final VoidCallback onPost;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _Avatar(),
            SizedBox(width: 10),
            Text(
              'Comment as loki',
              style: TextStyle(
                color: AppTheme.inkFor(context),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          key: const Key('commentField'),
          controller: controller,
          minLines: 4,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Write a comment...',
            hintStyle: TextStyle(
              color: AppTheme.mutedFor(context),
              fontSize: 14,
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? AppTheme.darkRaised
                : const Color(0xFFF3F5F8),
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(color: AppTheme.borderFor(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(color: AppTheme.borderFor(context)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: FilledButton(
            key: const Key('postComment'),
            onPressed: onPost,
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Post Comment',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}

class _CommentItem extends StatelessWidget {
  const _CommentItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.borderFor(context))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Avatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'loki',
                      style: TextStyle(
                        color: AppTheme.inkFor(context),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '21 detik lalu',
                      style: TextStyle(
                        color: AppTheme.mutedFor(context),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(
                    color: AppTheme.inkFor(context),
                    fontSize: 16,
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

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkRaised : const Color(0xFFEDF3FF),
        shape: BoxShape.circle,
      ),
      child: Text(
        'L',
        style: TextStyle(
          color: isDark ? AppTheme.darkBlue : AppTheme.blue,
        ),
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
