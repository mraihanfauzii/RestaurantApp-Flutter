import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingsPage({super.key});

  Widget _buildList(BuildContext context) {
    return Consumer2<PreferencesProvider, SchedulingProvider>(
      builder: (context, preferencesProvider, schedulingProvider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                    value: preferencesProvider.isDarkTheme,
                    onChanged: (value) {
                      preferencesProvider.enableDarkTheme(value);
                    },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text('Daily Reminder'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                        value: schedulingProvider.isScheduled,
                        onChanged: (value) async {
                          if (Platform.isIOS) {
                            customDialog(context);
                          } else {
                            await schedulingProvider.scheduledUpdates(value);
                          }
                        }
                      );
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: _buildList(context),
    );
  }
}