import 'Toy.dart';

class UserInfo {

  final String userId;
  final String screenName;
  final List<int> ageRange;
  final List<String> interests;
  final List<Toy> toys;
  final String profileImageUrl;

  UserInfo(
      this.userId,
      this.screenName,
      this.ageRange,
      this.interests,
      this.toys,
      this.profileImageUrl
      );
}