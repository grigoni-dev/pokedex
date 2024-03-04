import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/features/detail/presentation/screen/detail_screen.dart';
import 'package:pokedex/features/home/presentation/screen/home_screen.dart';

final _key = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _key,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const HomeScreen(),
      ),
      routes: [
        GoRoute(
          path: 'detail',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const DetailScreen(),
          ),
        ),
      ],
    ),
  ],
);

CustomTransitionPage<T> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return appRouter;
});
