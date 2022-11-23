import 'package:json_annotation/json_annotation.dart';
import 'Toy.dart';
part 'ProfileInfo.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ProfileInfo {

  String uid = '';
  String screenName = '';
  String ageRange = '';
  String interests = '';
  List<Toy> toys = <Toy>[];
  String profileImageUrl = '';
  double userRating = 0.0;
  int totalRates = 0;

 ProfileInfo({
   required this.uid,
   required this.screenName,
   required this.ageRange,
   required this.interests,
   required this.toys,
   required this.profileImageUrl,
   required this.userRating,
   required this.totalRates
 });

 factory ProfileInfo.fromJson(Map<String, dynamic> json) => _$ProfileInfoFromJson(json);
 Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);

}