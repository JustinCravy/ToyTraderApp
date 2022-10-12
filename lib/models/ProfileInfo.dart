import 'Toy.dart';

class ProfileInfo {

  final String userId;
  final String screenName;
  final List<int> ageRange;
  final List<String> interests;
  final List<Toy> toys;
  final String profileImageUrl;

 ProfileInfo({
   required this.userId,
   required this.screenName,
   required this.ageRange,
   required this.interests,
   required this.toys,
   required this.profileImageUrl
 });

}