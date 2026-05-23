import 'package:flutter/material.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

class DietRecordPage extends StatelessWidget {
  const DietRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pageDietTitle)),
      body: Center(child: Text(l.placeholderDiet)),
    );
  }
}
