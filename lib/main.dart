import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/provider/scheduling_provider.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/ui/home_page.dart';
import 'package:dicoding_fundamental_flutter_submission_2_restaurant_app/utils/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/navigation.dart';
import '../data/db/database_helper.dart';
import '../provider/database_provider.dart';
import '../provider/preferences_provider.dart';
import '../utils/background_service.dart';
import '../utils/notification_helper.dart';
import '../provider/restaurant_provider.dart';
import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';
import '../ui/detail_page.dart';
import '../ui/restaurant_list_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  _notificationHelper.configureSelectNotificationSubject(RestaurantDetailPage.routeName);

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService())
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())
          ),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
                preferencesHelper: PreferencesHelper(sharedPreferences: prefs)
            ),
          ),
          ChangeNotifierProvider(
              create: (_) => SchedulingProvider(
                preferencesHelper: PreferencesHelper(sharedPreferences: prefs)
              ),
          ),
        ],
        child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          title: 'Restaurant',
          theme: provider.themeData,
          initialRoute: HomePage.routeName,
          navigatorKey: navigatorKey,
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            RestaurantListPage.routeName: (context) => const RestaurantListPage(),
            RestaurantDetailPage.routeName: (context) {
              final restaurantId = ModalRoute.of(context)?.settings.arguments as String;
              return RestaurantDetailPage(restaurantId: restaurantId);
            }
          },
        );
      },
    );
  }
}