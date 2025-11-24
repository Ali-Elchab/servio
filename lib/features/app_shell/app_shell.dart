import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/core/router/app_router_paths.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  static final _tabs = <_TabDestination>[
    _TabDestination(label: 'Home', icon: Icons.home_rounded, path: RouterPaths.home),
    _TabDestination(label: 'Profile', icon: Icons.person_rounded, path: RouterPaths.profile),
    _TabDestination(label: 'Settings', icon: Icons.settings_rounded, path: RouterPaths.settings),
  ];

  int get _currentIndex {
    final loc = state.matchedLocation;
    final idx = _tabs.indexWhere((t) => loc == t.path || loc.startsWith('${t.path}/'));
    return idx < 0 ? 0 : idx;
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentIndex;
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: NavigationBar(
        selectedIndex: current,
        onDestinationSelected: (i) {
          if (i == current) return;
          context.go(_tabs[i].path);
        },
        destinations: _tabs
            .map((t) => NavigationDestination(
                  icon: Icon(t.icon),
                  label: t.label,
                ))
            .toList(growable: false),
      ),
    );
  }
}

class _TabDestination {
  final String label;
  final IconData icon;
  final String path;
  const _TabDestination({required this.label, required this.icon, required this.path});
}
