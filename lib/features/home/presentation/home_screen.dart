import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/providers/cubit/providers_cubit.dart';
import '/features/providers/data/models/provider.dart';
import '/features/categories/cubit/categories_cubit.dart';
import '/shared/extensions/context_extensions.dart';
import '/shared/widgets/language_drop_down.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Stream<List<Provider>> _providersStream;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProvidersCubit>();
    _providersStream = cubit.watch();
    cubit.load();
    context.read<CategoriesCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final syncing = context.select((ProvidersCubit c) => c.state.syncing);
    final error = context.select((ProvidersCubit c) => c.state.error);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('navigation.home')),
        actions: const [Padding(padding: EdgeInsets.only(right: 12), child: LanguageDropdown())],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Service providers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: syncing ? null : () => context.read<ProvidersCubit>().load(force: true),
                ),
              ],
            ),
            if (syncing) const LinearProgressIndicator(minHeight: 3),
            if (error != null) Padding(padding: const EdgeInsets.only(top: 8), child: Text(error, style: const TextStyle(color: Colors.red))),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<List<Provider>>(
                stream: _providersStream,
                builder: (context, snapshot) {
                  final providers = snapshot.data ?? const [];
                  if (providers.isEmpty) {
                    return Center(
                      child: Text(
                        syncing ? 'Syncing providers...' : 'No providers cached yet',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: providers.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final p = providers[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(p.name.isNotEmpty ? p.name[0].toUpperCase() : '?'),
                        ),
                        title: Text(p.name),
                        subtitle: Text(p.categoryName ?? 'Uncategorized'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
