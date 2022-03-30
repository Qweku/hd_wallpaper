import 'package:hive/hive.dart';
part 'urls.g.dart';

@HiveType(typeId: 10)
class Urls {
  Urls({
    required this.regular,
    required this.small,
  });

  @HiveField(10)
  String regular;
  @HiveField(11)
  String small;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        regular: json["regular"],
        small: json["small"],
      );

  Map<String, dynamic> toJson() => {
        "regular": regular,
        "small": small,
      };
}