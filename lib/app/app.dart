import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/app/router/router.dart';
import 'package:pokedex/core/presentation/theme/theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.read(appRouterProvider);
    return MaterialApp.router(
      theme: UITheme.theme,
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      routerConfig: appRouter,
    );
  }
}
