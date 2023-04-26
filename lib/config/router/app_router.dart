import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    
    // Home screen
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse( state.params['page'] ?? '0' );
        return HomeScreen( pageIndex: pageIndex );
      },
      routes: [
        // Movie screen
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) =>
              MovieScreen(movieId: state.params['id'] ?? 'no-id'),
        )
      ],
    ),

    GoRoute(
      path: '/',
      redirect: ( _ , __ ) => '/home/0',
    )

  ],
);