import 'package:get_it/get_it.dart';

import '../../feature/mood_listing/mood_listing.feature.dart';

final di = GetIt.instance;

Future<void> initInjection() async {
  di.registerFactory(() => MoodListingBloc());
}
