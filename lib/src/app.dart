import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challange/src/providers/auth/login_bloc.dart';
import 'package:flutter_challange/src/providers/auth/register_bloc.dart';
import 'package:flutter_challange/src/providers/feed/feed_bloc.dart';
import 'package:flutter_challange/src/providers/gathering/detail_gathering_bloc.dart';
import 'package:flutter_challange/src/providers/gathering/gathering_bloc.dart';
import 'package:flutter_challange/src/providers/gathering/member_list_bloc.dart';
import 'package:flutter_challange/src/providers/home/home_root_bloc.dart';
import 'package:flutter_challange/src/providers/notification/notification_bloc.dart';
import 'package:flutter_challange/src/providers/onboarding/oboarding_bloc.dart';
import 'package:flutter_challange/src/screens/auth/login_screen.dart';
import 'package:flutter_challange/src/screens/auth/register_screen.dart';
import 'package:flutter_challange/src/screens/feed/feed_screen.dart';
import 'package:flutter_challange/src/screens/gathering/detail_gathering_screen.dart';
import 'package:flutter_challange/src/screens/gathering/gathering_screen.dart';
import 'package:flutter_challange/src/screens/gathering/member_list_screen.dart';
import 'package:flutter_challange/src/screens/home/home_root_screen.dart';
import 'package:flutter_challange/src/screens/notification/notification_screen.dart';
import 'package:flutter_challange/src/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_challange/src/helpers/helpers.dart';
import 'package:flutter_challange/src/providers/splash/splash_bloc.dart';
import 'package:flutter_challange/src/screens/splash/splash_screen.dart';
import 'package:flutter_challange/src/screens/user/profile_screen.dart';
import 'package:flutter_challange/src/providers/user/user_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, // Color for Android
        statusBarBrightness:
            Brightness.light // Dark == white status bar -- for IOS.
        ));
    return MaterialApp(
      title: 'Flutter Challange',
      theme: ThemeData(fontFamily: 'Nunito', brightness: Brightness.light),
      onGenerateRoute: routes,
      navigatorKey: Helpers.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }

  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<SplashBloc>.value(
              value: SplashBloc(),
              child: SplashScreen(),
            );
          },
        );
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<OnboardingBloc>.value(
              value: OnboardingBloc(),
              child: OnboardingScreen(),
            );
          },
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<LoginBloc>.value(
              value: LoginBloc(),
              child: LoginScreen(),
            );
          },
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<RegisterBloc>.value(
              value: RegisterBloc(),
              child: RegisterScreen(),
            );
          },
        );
      case HomeRootScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<HomeRootBloc>.value(
                  value: HomeRootBloc(),
                  child: HomeRootScreen(),
                ),
                ChangeNotifierProvider<FeedBloc>.value(
                  value: FeedBloc(),
                  child: FeedScreen(),
                ),
                ChangeNotifierProvider<GatheringBloc>.value(
                  value: GatheringBloc(),
                  child: GatheringScreen(),
                ),
                ChangeNotifierProvider<NotificationBloc>.value(
                  value: NotificationBloc(),
                  child: NotificationScreen(),
                ),
                ChangeNotifierProvider<UserBloc>.value(
                  value: UserBloc(),
                  child: ProfileScreen(),
                ),
              ],
              child: HomeRootScreen(),
            );
          },
        );
      case ProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<UserBloc>.value(
              value: UserBloc(),
              child: ProfileScreen(),
            );
          },
        );
      case DetailGatheringScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<DetailGatheringBloc>.value(
              value: DetailGatheringBloc(),
              child: DetailGatheringScreen(),
            );
          },
        );
      case MemberListScreen.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider<MemberListBloc>.value(
              value: MemberListBloc(),
              child: MemberListScreen(),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
