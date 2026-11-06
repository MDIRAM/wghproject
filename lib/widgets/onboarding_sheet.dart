import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class OnboardingSheet extends StatelessWidget {
  const OnboardingSheet({
    super.key,
    required this.onStayLoggedOut,
    required this.onSignIn,
  });

  final VoidCallback onStayLoggedOut;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.borderFor(context),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 19),
            Text(
              'WGH',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkBlue
                    : AppTheme.blue,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Log In or Create Account',
              style: TextStyle(
                color: AppTheme.inkFor(context),
                fontSize: 27,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Simpan panduan favorit dan ikut berdiskusi. Masuk hanya dengan akun Google, atau lanjutkan membaca sebagai Guest.',
              style: TextStyle(
                color: AppTheme.mutedFor(context),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton.icon(
                key: const Key('continueWithGoogle'),
                onPressed: onSignIn,
                icon: const Text(
                  'G',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                key: const Key('stayLoggedOut'),
                onPressed: onStayLoggedOut,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.inkFor(context),
                  side: BorderSide(color: AppTheme.borderFor(context)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Stay Logged Out',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 17),
            Center(
              child: Text(
                'Dengan melanjutkan, Anda menyetujui Terms of Use dan Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppTheme.mutedFor(context),
                  fontSize: 10,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
