import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quadrant_master/providers/tasks_provider.dart';
import 'package:quadrant_master/screens/home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:quadrant_master/screens/quadrant_detail_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// 将 main 函数更改为异步，并等待 tasksProvider.loadTasks() 完成
void main() async {
// 确保在调用setMethodCallHandler()之前初始化WidgetsFlutterBinding
/*
 * WidgetFlutterBinding是用来与Flutter引擎交互的。
 * Firebase.initializeApp()需要调用本机代码来初始化Firebase。
 * 由于插件需要使用平台通道来调用本机代码(这是异步完成的)，
 * 因此必须调用ensureInitialized()来确保拥有WidgetsBinding的实例。
 */
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // 初始化通知插件
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  WidgetsFlutterBinding.ensureInitialized(); // 在使用异步方法前确保Flutter绑定初始化
  final tasksProvider = TasksProvider();
  await tasksProvider.loadTasks(); // 加载任务列表

  runApp(
    // 将 ChangeNotifierProvider 移到了 runApp 函数内，这样你可以在加载任务列表后将 tasksProvider 传递给它
    ChangeNotifierProvider(
      create: (context) => tasksProvider,
      child: MyApp(navigatorKey),
    ),
  );
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) {
  if (notificationResponse.notificationResponseType ==
      NotificationResponseType.selectedNotification) {
    String payload = notificationResponse.payload ?? '';
    int quadrant = int.tryParse(payload) ?? 0;
    if (quadrant > 0) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => QuadrantDetailScreen(
              quadrant: quadrant), // 根据通知的有效负载（象限编号）导航到相应的象限页面
        ),
      );
    }
  }
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  MyApp(this.navigatorKey);

// 移除了 const MyApp() 构造函数中的 key 参数，因为它在这里没有用处

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Quadrant Master',
          theme: ThemeData(
            colorScheme: lightColorScheme ??
                ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme ??
                ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
