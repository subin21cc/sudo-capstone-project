import 'package:flutter/material.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pageExerciseTitle)),
      body: Center(child: Text(l.placeholderExercise)),
    );
  }
}
