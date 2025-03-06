import 'package:audition/core/domain/providers/contest_providers.dart';
import 'package:audition/core/domain/providers/home_videos_providers.dart';
import 'package:audition/core/domain/providers/search_providers.dart';
import 'package:audition/core/domain/providers/user_detail_providers.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> getAllProviders() => [
        ChangeNotifierProvider(create: (_) => HomeVideosProviders()),
        ChangeNotifierProvider(create: (_) => SearchProviders()),
        ChangeNotifierProvider(create: (_) => ContestProviders()),
        ChangeNotifierProvider(create: (_) => UserDetailProviders()),
      ];
}
