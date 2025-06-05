import 'package:auto_route/auto_route.dart';
import 'package:whoami_app/features/features.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
  );

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AuthShellRoute.page,
      initial: true,
      children: [
        AutoRoute(page: AuthInputEmailRoute.page, initial: true),
        AutoRoute(page: AuthInputCodeRoute.page),
        AutoRoute(page: AuthSuccessRoute.page),
      ],
    ),
    AutoRoute(page: UserRoute.page),
  ];
}
