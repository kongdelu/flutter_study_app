import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()//执行命令：flutter packages pub run build_runner build
class Author {
  String name;
  String title;
  int id;
  Author({this.name,this.title,this.id});

  factory Author.fromJson(Map<String,dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson(Author instance)=>_$AuthorToJson(instance);
}