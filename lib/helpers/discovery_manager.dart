import 'package:datingapp/data/current_user.dart';

class DiscoveryManager {
  late CurrentUser currentUser;
  DiscoveryManager(CurrentUser givenUser) {
    currentUser = givenUser;
  }
}
