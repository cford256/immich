import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/extensions/translate_extensions.dart';
import 'package:immich_mobile/presentation/widgets/bottom_sheet/trash_bottom_sheet.widget.dart';
import 'package:immich_mobile/presentation/widgets/timeline/timeline.widget.dart';
import 'package:immich_mobile/providers/infrastructure/timeline.provider.dart';
import 'package:immich_mobile/providers/server_info.provider.dart';
import 'package:immich_mobile/providers/user.provider.dart';

@RoutePage()
class DriftTrashPage extends StatelessWidget {
  const DriftTrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        timelineServiceProvider.overrideWith((ref) {
          final user = ref.watch(currentUserProvider);
          if (user == null) {
            throw Exception('User must be logged in to access trash');
          }

          final timelineService = ref.watch(timelineFactoryProvider).trash(user.id);
          ref.onDispose(timelineService.dispose);
          return timelineService;
        }),
      ],
      child: Timeline(
        showStorageIndicator: true,
        appBar: SliverAppBar(
          title: Text('trash'.t(context: context)),
          floating: true,
          snap: true,
          pinned: true,
          centerTitle: true,
          elevation: 0,
        ),
        topSliverWidgetHeight: 24,
        topSliverWidget: Consumer(
          builder: (context, ref, child) {
            final trashDays = ref.watch(serverInfoProvider.select((v) => v.serverConfig.trashDays));

            return SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.0,
                  child: const Text("trash_page_info").t(context: context, args: {"days": "$trashDays"}),
                ),
              ),
            );
          },
        ),
        bottomSheet: const TrashBottomBar(),
      ),
    );
  }
}
