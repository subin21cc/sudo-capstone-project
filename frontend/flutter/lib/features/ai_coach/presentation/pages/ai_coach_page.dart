import 'package:flutter/material.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

class AICoachPage extends StatelessWidget {
  const AICoachPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pageAiCoachTitle)),
      body: Center(child: Text(l.placeholderAiCoach)),
    );
  }
}
