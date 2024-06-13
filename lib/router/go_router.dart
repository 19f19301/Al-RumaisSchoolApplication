
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school/auth/profile.dart';
import 'package:school/home/home.dart';
import 'package:school/moodels/google_nav_bar.dart';
import 'package:school/notifications.dart/notification.dart';
import 'package:school/search/search.dart';


class AppNavigation {
  AppNavigation._();

  static String initial = '/home';

  static final _rootNavigationKey = GlobalKey<NavigatorState>();

  static final _shellNavigatorHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorSearch =
      GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
        static final _shellNavigatorNotifications =
      GlobalKey<NavigatorState>(debugLabel: 'shellNotifications');
  static final _shellNavigatorProfile =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  static final GoRouter router = GoRouter(
      initialLocation: initial,
      navigatorKey: _rootNavigationKey,
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return GoogleNavBar(
                navigationShell: navigationShell,
              );
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorHome,
                  routes: <RouteBase>[
                    GoRoute(
                      path: '/home',
                      name: 'Home',
                      builder: (context, state) => const Home(),
                    )
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorSearch ,
                  routes: <RouteBase>[
                    GoRoute(
                        path: '/search',
                        name: 'Search',
                        builder: (context, state) => const Search(),
                    )  
                  ]),
              StatefulShellBranch(
                  navigatorKey: _shellNavigatorNotifications,
                  routes: <RouteBase>[
                    GoRoute(
                      path: '/notifications',
                      name: 'Notifications',
                      builder: (context, state) => const Notifications(),
                    )
                  ]),
          
                   StatefulShellBranch(
                  navigatorKey: _shellNavigatorProfile ,
                  routes: <RouteBase>[
                    GoRoute(
                      path: '/auth',
                      name: 'Profile',
                      builder: (context, state) => const Profile(),
                    )
                  ]),
            ]),
            
      ]);
}
