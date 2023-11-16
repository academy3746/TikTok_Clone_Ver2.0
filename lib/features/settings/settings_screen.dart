import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/features/auth/repo/auth_repo.dart';
import 'package:tiktok/features/videos/view_models/play_back_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              title: const Text("Mute All"),
              subtitle: const Text("Kill all sound of videos by default"),
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) {
                ref.read(playbackConfigProvider.notifier).setMuted(value);
              },
            ),
            SwitchListTile.adaptive(
              title: const Text("Autoplay"),
              subtitle: const Text("Play videos automatically by default"),
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) {
                ref.read(playbackConfigProvider.notifier).setAutoPlay(value);
              },
            ),
            SwitchListTile.adaptive(
              title: const Text("Enable Notifications"),
              value: false,
              onChanged: (value) {},
            ),
            SwitchListTile.adaptive(
              title: const Text("Open my INFO"),
              subtitle: const Text("Users can check your information"),
              value: false,
              onChanged: (value) {},
            ),
            ListTile(
              onTap: () => showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2030),
              ),
              title: const Text("When is your birthday?"),
            ),
            const AboutListTile(
              applicationVersion: "1.0",
              applicationLegalese: "All rights reserved by Jonghyun Lee.",
            ),
            ListTile(
              title: const Text("Logout"),
              textColor: Theme.of(context).primaryColor,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Please, do not leave us~!"),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text("NO"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text("YES"),
                        onPressed: () {
                          ref.read(authRepo).signOut();
                          context.go("/");
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
