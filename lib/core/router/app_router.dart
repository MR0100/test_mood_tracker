import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../feature/mood_listing/mood_listing.feature.dart'
    show MoodListingBloc, MoodEntryListingScreen;
import '../di/injection_container.dart';

class AppRouter {
  static const String moodEntryListing = "/mood-entry-listing";

  static final GoRouter router = GoRouter(
    initialLocation: moodEntryListing,
    routes: [
      GoRoute(
        path: moodEntryListing,
        builder: (context, state) => BlocProvider(
          create: (_) => di<MoodListingBloc>(),
          child: const MoodEntryListingScreen(),
        ),
      ),
    ],
  );
}
