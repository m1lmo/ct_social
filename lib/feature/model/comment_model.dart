import 'package:ct_social/core/database/core/hive_types.dart';
import 'package:ct_social/core/database/core/model/hive_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.commentModelId)
@immutable
final class CommentModel with EquatableMixin, HiveModelMixin {
  CommentModel({
    this.id,
    this.comment,
    this.user,
    this.commentedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? comment;
  @HiveField(2)
  final UserModel? user;
  @HiveField(3)
  final DateTime? commentedAt;

  Map<String, dynamic> toJson() {
    return _$CommentModelToJson(this);
  }

  CommentModel copyWith({
    DateTime? commentedAt,
    String? id,
    String? comment,
    UserModel? user,
  }) {
    return CommentModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      user: user ?? this.user,
      commentedAt: commentedAt ?? this.commentedAt,
    );
  }

  @override
  List<Object?> get props => [id, comment, user, commentedAt];

  @override
  String get boxKey => id.toString();
}
