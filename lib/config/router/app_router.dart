import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(

  initialLocation: '/',

  routes: [

    // Home screen
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder:(context, state) => const HomeScreen(),
    )

  ]

);