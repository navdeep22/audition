import 'package:audition/features/home/presentation/widgets/home_feeds.dart';
import 'package:audition/features/home/presentation/widgets/home_header.dart';
import 'package:audition/features/home/presentation/widgets/live_contests_home.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool enableLiveContest = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!enableLiveContest) const HomeFeeds(),
        if (enableLiveContest) const LiveContestsHome(),
        HomeHeader(
          isLiveContestSelected: (enable) {
            _togglePageSelector(enable);
          },
          isEnable: !enableLiveContest,
        )
      ],
    );
  }

  _togglePageSelector(bool enable) {
    setState(() {
      enableLiveContest = enable;
    });
  }
}
