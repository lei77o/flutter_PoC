import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/accounts/presentation/screens/accounts_screen.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/accounts/accounts.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';

final goRouterProvider = Provider((ref){

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* First Route
      ///
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Accounts Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const AccountsScreen(),
      ),
      ///* Account Routes
      GoRoute(
        path: '/account/:id',
        builder: (context, state) {
          return AccountScreen(accountId: state.pathParameters['id'].toString());
        },
      ),
    ],
    redirect: (context, state) {

      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash' ){
          return '/';
        }
      }

      return null;
    },
  );
});

