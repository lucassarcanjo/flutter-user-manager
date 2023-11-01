import 'package:flutter/material.dart';
import 'package:flutter_user_manager/src/features/home.dart';
import 'package:flutter_user_manager/src/features/login.dart';
import 'package:flutter_user_manager/src/features/register.dart';
import 'package:flutter_user_manager/src/features/welcome.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'Shell A');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'Shell B');

final router = GoRouter(
    initialLocation: '/welcome',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: '/welcome', builder: (context, state) => const Welcome()),
      GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
          routes: [
            GoRoute(
                path: 'register',
                builder: (context, state) => const RegisterScreen()),
            StatefulShellRoute.indexedStack(
                builder: (context, state, navigationShell) {
                  return ScaffoldWithNestedNavigation(
                      navigationShell: navigationShell);
                },
                branches: [
                  StatefulShellBranch(
                      navigatorKey: _shellNavigatorAKey,
                      routes: [
                        GoRoute(
                            path: 'a',
                            pageBuilder: (context, state) =>
                                const NoTransitionPage(child: Home()),
                            routes: [
                              GoRoute(
                                  path: 'details',
                                  builder: (context, state) =>
                                      const Text("Details A"))
                            ])
                      ]),
                  StatefulShellBranch(
                      navigatorKey: _shellNavigatorBKey,
                      routes: [
                        GoRoute(
                            path: 'b',
                            pageBuilder: (context, state) =>
                                const NoTransitionPage(child: Text("Page B"))),
                      ])
                ])
          ]),
      // Stateful nested navigation
    ]);

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({Key? key, required this.navigationShell})
      : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(index,
        initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: navigationShell,
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: navigationShell.currentIndex,
            onTap: _goBranch,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Colors.pink,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.search),
                title: const Text("Search"),
                selectedColor: Colors.orange,
              ),
            ]));
  }
}
