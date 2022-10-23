import 'Toy.dart';

class ProfileInfo {

  String userId = '';
  String screenName = '';
  String ageRange = '';
  String interests = '';
  List<Toy> toys = <Toy>[];
  String profileImageUrl = '';

 ProfileInfo({
   required this.userId,
   required this.screenName,
   required this.ageRange,
   required this.interests,
   required this.toys,
   required this.profileImageUrl
 });

}