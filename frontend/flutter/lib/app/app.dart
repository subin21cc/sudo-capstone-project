import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oncare/app/router/app_router.dart';

class OncareApp extends ConsumerWidget {
  const OncareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final base = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF3F8EFC),
    );
    final dark = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF3F8EFC),
      brightness: Brightness.dark,
    );

    return MaterialApp.router(
      title: 'Oncare',
      debugShowCheckedModeBanner: false,
      theme: base,
      darkTheme: dark,
      routerConfig: router,
    );
  }
}
