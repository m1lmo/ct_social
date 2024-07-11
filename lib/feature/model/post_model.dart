import 'package:ct_social/core/database/core/hive_types.dart';
import 'package:ct_social/core/database/core/model/hive_model.dart';
import 'package:ct_social/core/helper/uint8list_converter.dart';
import 'package:ct_social/feature/model/comment_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.postModelId)
@immutable
final class PostModel with EquatableMixin, HiveModelMixin {
  PostModel({
    this.title,
    this.header,
    this.bodyImage,
    this.body,
    required this.user,
    this.postTime,
    required this.comments,
    required this.likes,
    this.id,
  });
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? header;
  @HiveField(2)
  @Uint8ListConverter()
  final Uint8List? bodyImage;
  @HiveField(3)
  final String? body;
  @HiveField(4)
  final UserModel user;
  @HiveField(5)

  /// this is shouldnt be null dont forget the set
  ///  on addPost method with copyWith
  ///  which is in [PostCubit]
  final DateTime? postTime;
  @HiveField(6)
  final List<CommentModel?>? comments;
  @HiveField(7)
  final List<UserModel>? likes;
  @HiveField(8)

  /// this is shouldnt be null too set on addPost method with copyWith
  final int? id;

  PostModel copyWith({
    String? title,
    String? header,
    Uint8List? bodyImage,
    String? body,
    UserModel? user,
    List<CommentModel?>? comments,
    DateTime? postTime,
    List<UserModel>? likes,
    int? id,
  }) {
    return PostModel(
      title: title ?? this.title,
      header: header ?? this.header,
      bodyImage: bodyImage ?? this.bodyImage,
      body: body ?? this.body,
      user: user ?? this.user,
      postTime: postTime ?? this.postTime,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      id: id ?? this.id,
    );
  }

  @override
  String get boxKey => id.toString();

  @override
  List<Object?> get props => [title, body, user, id, postTime, comments, likes];

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return _$PostModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PostModelToJson(this);
  }
}
