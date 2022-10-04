import 'Toy.dart';

class ProfileInfo {

  final String userId;
  final String screenName;
  final List<int> ageRange;
  final List<String> interests;
  final List<Toy> toys;
  final String profileImageUrl;

 ProfileInfo(
      this.userId,
      this.screenName,
      this.ageRange,
      this.interests,
      this.toys,
      this.profileImageUrl
      );
}