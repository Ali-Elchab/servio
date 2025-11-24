import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/shared/cubits/network/network_cubit.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocBuilder<NetworkCubit, NetState>(
      buildWhen: (a, b) => a.isKnown != b.isKnown || a.isOnline != b.isOnline,
      builder: (_, s) {
        if (!s.isKnown) return const SizedBox.shrink();
        final visible = !s.isOnline;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child: !visible
              ? const SizedBox(height: 0, key: ValueKey('hidden'))
              : Container(
                  key: const ValueKey('shown'),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: scheme.error,
                    border: Border(
                      bottom: BorderSide(color: scheme.onErrorContainer.withOpacity(0.12)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'You’re offline',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class ConnectivityScaffold extends StatelessWidget {
  final Widget child;
  final bool showBanner;
  final bool safeTop;
  final bool safeBottom;
  final EdgeInsetsGeometry? padding;
  final bool useScaffold;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const ConnectivityScaffold({
    super.key,
    required this.child,
    this.showBanner = true,
    this.safeTop = true,
    this.safeBottom = false,
    this.padding,
    this.useScaffold = false,
    this.appBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (showBanner) const ConnectivityBanner(),
        Expanded(
          child: child,
        ),
      ],
    );

    content = SafeArea(top: safeTop, bottom: safeBottom, child: content);

    if (!useScaffold) return content;

    return Scaffold(
      body: content,
    );
  }
}
