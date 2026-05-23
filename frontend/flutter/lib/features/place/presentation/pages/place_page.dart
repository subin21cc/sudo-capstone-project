import 'package:flutter/material.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

class PlacePage extends StatelessWidget {
  const PlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pagePlaceTitle)),
      body: Center(child: Text(l.placeholderPlace)),
    );
  }
}
