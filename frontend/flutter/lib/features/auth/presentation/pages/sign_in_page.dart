import 'package:flutter/material.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pageSignInTitle)),
      body: Center(child: Text(l.placeholderSignIn)),
    );
  }
}
