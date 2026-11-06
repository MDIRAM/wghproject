import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:perc/app.dart';
import 'package:perc/theme/app_theme.dart';
import 'package:perc/widgets/onboarding_sheet.dart';

void main() {
  testWidgets('shows onboarding over home feed on first launch', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();

    expect(find.text('Log In or Create Account'), findsOneWidget);
    expect(find.text('Your next adventure.'), findsOneWidget);
    expect(find.byKey(const Key('stayLoggedOut')), findsOneWidget);
  });

  testWidgets('guest can continue to the home feed', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();

    expect(find.text('Your next adventure.'), findsOneWidget);
    expect(find.text('Limgrave Barat: Awal Perjalanan'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('guest can read comments but cannot post', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openArticle')));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).last, const Offset(0, -1800));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('openComments')));
    await tester.tap(find.byKey(const Key('openComments')));
    await tester.pumpAndSettle();

    expect(find.text('Log in to comment'), findsOneWidget);
    expect(find.text('bagus'), findsOneWidget);
    expect(find.byKey(const Key('commentField')), findsNothing);
  });

  testWidgets('member can save article and post a comment', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('continueWithGoogle')));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('loki@example.com'), findsOneWidget);

    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openArticle')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('bookmarkButton')));
    await tester.pumpAndSettle();

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('1 saved'), findsOneWidget);
    expect(find.byKey(const Key('savedArticle')), findsOneWidget);

    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openArticle')));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).last, const Offset(0, -1800));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('openComments')));
    await tester.tap(find.byKey(const Key('openComments')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('commentField')),
      'Helpful guide',
    );
    await tester.tap(find.byKey(const Key('postComment')));
    await tester.pumpAndSettle();

    expect(find.text('Helpful guide'), findsOneWidget);
    expect(find.text('2 comments'), findsOneWidget);
  });

  testWidgets('guest profile shows bookmark sign-in prompt', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Browsing as Guest'), findsOneWidget);
    expect(find.text('Keep your place.'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
  });

  testWidgets('reviews filter switches feed and back to games', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('REVIEWS'));
    await tester.pumpAndSettle();

    expect(find.text('Reviews.'), findsOneWidget);
    expect(find.text('Elden Ring Review'), findsOneWidget);
    await tester.drag(find.byType(ListView).last, const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(find.text('Sekiro Review'), findsOneWidget);

    await tester.drag(find.byType(ListView).last, const Offset(0, 1000));
    await tester.pumpAndSettle();
    await tester.tap(find.text('GAMES'));
    await tester.pumpAndSettle();
    expect(find.text('Your next adventure.'), findsOneWidget);
  });

  testWidgets('game cards use matching images from the current mockups', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();

    expect(
      (tester
                  .widget<Image>(
                    find.byKey(
                      const Key('feedImage-Limgrave Barat: Awal Perjalanan'),
                    ),
                  )
                  .image
              as AssetImage)
          .assetName,
      'assets/images/elden_ring_guide.png',
    );
    await tester.dragUntilVisible(
      find.text('How To Unlock Joker Boss Fight'),
      find.byType(ListView).last,
      const Offset(0, -250),
    );
    expect(
      (tester
                  .widget<Image>(
                    find.byKey(
                      const Key('feedImage-How To Unlock Joker Boss Fight'),
                    ),
                  )
                  .image
              as AssetImage)
          .assetName,
      'assets/images/persona3_reload.png',
    );
    await tester.dragUntilVisible(
      find.text('How To Beat Izanami'),
      find.byType(ListView).last,
      const Offset(0, -250),
    );
    expect(
      (tester
                  .widget<Image>(
                    find.byKey(const Key('feedImage-How To Beat Izanami')),
                  )
                  .image
              as AssetImage)
          .assetName,
      'assets/images/persona4_golden.png',
    );

    await tester.drag(find.byType(ListView).last, const Offset(0, 1000));
    await tester.pumpAndSettle();
    await tester.tap(find.text('REVIEWS'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('Sekiro Review'),
      find.byType(ListView).last,
      const Offset(0, -250),
    );
    expect(
      (tester
                  .widget<Image>(
                    find.byKey(const Key('reviewImage-Sekiro Review')),
                  )
                  .image
              as AssetImage)
          .assetName,
      'assets/images/sekiro_review.png',
    );
  });

  testWidgets('review card opens review article and score details', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('REVIEWS'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openReview-Elden Ring Review')));
    await tester.pumpAndSettle();

    expect(find.text('Elden Ring Review'), findsOneWidget);
    expect(find.text('Gameplay'), findsOneWidget);
    await tester.dragUntilVisible(
      find.text('Alasan di balik penilaian'),
      find.byType(ListView).last,
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.text('Alasan di balik penilaian'), findsOneWidget);
    expect(find.text('Hasil Review'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('review article shows comments in light mode', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('REVIEWS'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openReview-Elden Ring Review')));
    await tester.pumpAndSettle();

    final commentsButton = find.byKey(const Key('openReviewComments'));
    await tester.dragUntilVisible(
      commentsButton,
      find.byType(ListView).last,
      const Offset(0, -500),
    );
    expect(find.text('Show Comments'), findsOneWidget);
    await tester.tap(commentsButton);
    await tester.pumpAndSettle();

    expect(find.text('Comments'), findsOneWidget);
  });

  testWidgets('search filters guides and clears query', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('searchField')), 'Elden');
    await tester.pumpAndSettle();
    expect(find.text('3 matching guides · Elden Ring'), findsOneWidget);
    expect(find.text('Stormveil Castle: Margit dan Godrick'), findsOneWidget);

    await tester.tap(find.byKey(const Key('clearSearch')));
    await tester.pumpAndSettle();
    expect(find.text('Search by game title.'), findsOneWidget);
  });

  testWidgets('settings changes theme and signs member out', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('continueWithGoogle')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('homeSettingsButton')));
    await tester.pumpAndSettle();

    expect(find.text('Account'), findsOneWidget);
    expect(find.text('loki@example.com'), findsOneWidget);
    await tester.tap(find.byKey(const Key('appearanceDark')));
    await tester.pumpAndSettle();
    expect(
      Theme.of(tester.element(find.text('Settings'))).brightness,
      Brightness.dark,
    );

    await tester.drag(find.byType(ListView).last, const Offset(0, -800));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('signOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Browsing as Guest'), findsOneWidget);
  });

  testWidgets('guest settings sign-in returns to member profile', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('stayLoggedOut')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('homeSettingsButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('loki@example.com'), findsOneWidget);
  });

  testWidgets('dark mockups use readable colors across app screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WghApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('continueWithGoogle')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('homeSettingsButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('appearanceDark')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(
      tester.widget<Text>(find.text('GAMES')).style?.color,
      AppTheme.darkSurface,
    );

    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('searchField')), 'Elden');
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('Search by game title.'),
      find.byType(ListView).first,
      const Offset(0, -250),
    );
    expect(find.text('Search by game title.'), findsOneWidget);

    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openArticle')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('bookmarkButton')));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('Semua panduan tersimpan ada di My Bookmarks.'),
      find.byType(ListView).last,
      const Offset(0, -250),
    );
    expect(
      tester
          .widget<Text>(
            find.text('Semua panduan tersimpan ada di My Bookmarks.'),
          )
          .style
          ?.color,
      AppTheme.darkMuted,
    );

    await tester.tap(find.text('Beranda'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('openArticle')));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<Text>(find.text('ELDEN RING / PANDUAN UTAMA / BAB 1'))
          .style
          ?.color,
      AppTheme.darkBlue,
    );
    await tester.dragUntilVisible(
      find.byKey(const Key('openComments')),
      find.byType(ListView).last,
      const Offset(0, -500),
    );
    await tester.tap(find.byKey(const Key('openComments')));
    await tester.pumpAndSettle();
    expect(
      tester.widget<Text>(find.text('ELDEN RING · BAB 1')).style?.color,
      AppTheme.darkBlue,
    );
  });

  testWidgets('onboarding adapts to dark theme', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(
          body: OnboardingSheet(onStayLoggedOut: () {}, onSignIn: () {}),
        ),
      ),
    );

    expect(
      tester.widget<Text>(find.text('WGH')).style?.color,
      AppTheme.darkBlue,
    );
    expect(
      tester.widget<Text>(find.text('Log In or Create Account')).style?.color,
      AppTheme.darkInk,
    );
  });
}
