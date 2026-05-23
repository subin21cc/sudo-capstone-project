import 'package:flutter/material.dart';

import 'package:oncare/gen/l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.pageNotificationTitle)),
      body: Center(child: Text(l.placeholderNotification)),
    );
  }
}
