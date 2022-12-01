
import 'package:json_annotation/json_annotation.dart';
part 'Toy.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Toy {

   String toyId = '';
   String ownerId = '';
   String name = '';
   String description = '';
   String condition = '';
   String ageRange = '';
   String categories = '';
   String toyImageURL = '';

  Toy (
      this.toyId,
      this.ownerId,
      this.name,
      this.description,
      this.condition,
      this.ageRange,
      this.categories,
      this.toyImageURL,
      );


   factory Toy.fromJson(Map<String, dynamic> json) => _$ToyFromJson(json);
   Map<String, dynamic> toJson() => _$ToyToJson(this);
  get id => toyId;

  bool checkNullValue() {
    return [name,description,condition,ageRange,categories].contains('');
  }
}
