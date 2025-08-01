import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/models/cast/cast_manager_state.dart';
import 'package:immich_mobile/presentation/widgets/asset_viewer/asset_viewer.state.dart';
import 'package:immich_mobile/providers/asset_viewer/video_player_controls_provider.dart';
import 'package:immich_mobile/providers/asset_viewer/video_player_value_provider.dart';
import 'package:immich_mobile/providers/cast.provider.dart';
import 'package:immich_mobile/providers/infrastructure/asset_viewer/current_asset.provider.dart';
import 'package:immich_mobile/utils/hooks/timer_hook.dart';
import 'package:immich_mobile/widgets/asset_viewer/center_play_button.dart';
import 'package:immich_mobile/widgets/common/delayed_loading_indicator.dart';

class VideoViewerControls extends HookConsumerWidget {
  final Duration hideTimerDuration;

  const VideoViewerControls({super.key, this.hideTimerDuration = const Duration(seconds: 5)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetIsVideo = ref.watch(currentAssetNotifier.select((asset) => asset != null && asset.isVideo));
    bool showControls = ref.watch(assetViewerProvider.select((s) => s.showingControls));
    final showBottomSheet = ref.watch(assetViewerProvider.select((s) => s.showingBottomSheet));
    if (showBottomSheet) {
      showControls = false;
    }
    final VideoPlaybackState state = ref.watch(videoPlaybackValueProvider.select((value) => value.state));

    final cast = ref.watch(castProvider);

    // A timer to hide the controls
    final hideTimer = useTimer(hideTimerDuration, () {
      if (!context.mounted) {
        return;
      }
      final state = ref.read(videoPlaybackValueProvider).state;

      // Do not hide on paused
      if (state != VideoPlaybackState.paused && state != VideoPlaybackState.completed && assetIsVideo) {
        ref.read(assetViewerProvider.notifier).setControls(false);
      }
    });
    final showBuffering = state == VideoPlaybackState.buffering && !cast.isCasting;

    /// Shows the controls and starts the timer to hide them
    void showControlsAndStartHideTimer() {
      hideTimer.reset();
      ref.read(assetViewerProvider.notifier).setControls(true);
    }

    // When we change position, show or hide timer
    ref.listen(videoPlayerControlsProvider.select((v) => v.position), (previous, next) {
      showControlsAndStartHideTimer();
    });

    /// Toggles between playing and pausing depending on the state of the video
    void togglePlay() {
      showControlsAndStartHideTimer();

      if (cast.isCasting) {
        if (cast.castState == CastState.playing) {
          ref.read(castProvider.notifier).pause();
        } else if (cast.castState == CastState.paused) {
          ref.read(castProvider.notifier).play();
        } else if (cast.castState == CastState.idle) {
          // resend the play command since its finished
          final asset = ref.read(currentAssetNotifier);
          if (asset == null) {
            return;
          }
          // ref.read(castProvider.notifier).loadMedia(asset, true);
        }
        return;
      }

      if (state == VideoPlaybackState.playing) {
        ref.read(videoPlayerControlsProvider.notifier).pause();
      } else if (state == VideoPlaybackState.completed) {
        ref.read(videoPlayerControlsProvider.notifier).restart();
      } else {
        ref.read(videoPlayerControlsProvider.notifier).play();
      }
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: showControlsAndStartHideTimer,
      child: AbsorbPointer(
        absorbing: !showControls,
        child: Stack(
          children: [
            if (showBuffering)
              const Center(child: DelayedLoadingIndicator(fadeInDuration: Duration(milliseconds: 400)))
            else
              GestureDetector(
                onTap: () => ref.read(assetViewerProvider.notifier).setControls(false),
                child: CenterPlayButton(
                  backgroundColor: Colors.black54,
                  iconColor: Colors.white,
                  isFinished: state == VideoPlaybackState.completed,
                  isPlaying:
                      state == VideoPlaybackState.playing || (cast.isCasting && cast.castState == CastState.playing),
                  show: assetIsVideo && showControls,
                  onPressed: togglePlay,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
