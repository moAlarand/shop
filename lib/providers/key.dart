import 'package:json_annotation/json_annotation.dart';

part 'key.g.dart';

@JsonSerializable()
class Key {
  final name;
  Key(this.name);
  factory Key.fromJson(Map<String, dynamic> json) => _$KeyFromJson(json);
  Map<String, dynamic> toJson() => _$KeyToJson(this);
}
