import 'package:flutter/material.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

class MyHealthPage extends StatelessWidget {
  const MyHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pageMyHealthTitle)),
      body: Center(child: Text(l.placeholderMyHealth)),
    );
  }
}
