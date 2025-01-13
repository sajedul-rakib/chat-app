import 'package:chat_app/features/signup/data/models/user.dart';

abstract class UserRepo {
  //get friends who connect with subscriber
  Future<List<MyUser>> getSubscriberFriendList(String subscriberUniqueId);
}
