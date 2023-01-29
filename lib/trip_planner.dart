import 'package:flutter/material.dart';
import 'package:aws_amplify_tut/common/navigation/router/route.dart';
import 'package:aws_amplify_tut/features/trip/ui/trip_list/trip_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:aws_amplify_tut/common/utils/colors.dart' as constants;

class TripsPlannerApp extends StatelessWidget {
  const TripsPlannerApp({
    required this.isAmplifySuccessfullyConfigured,
    Key? key,
  }) : super(key: key);

  final bool isAmplifySuccessfullyConfigured;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) => isAmplifySuccessfullyConfigured
              ? const TripsListPage()
              : const Scaffold(
                  body: Center(
                    child: Text(
                      'Tried to reconfigure Amplify; '
                      'this can occur when your app restarts on Android.',
                    ),
                  ),
                ),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    );

    return Authenticator(
      child: MaterialApp.router(
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        builder: Authenticator.builder(),
        theme: ThemeData(
          primarySwatch: constants.primaryColor,
          backgroundColor: const Color(0xff82CFEA),
        ),
      ),
    );
  }
}
