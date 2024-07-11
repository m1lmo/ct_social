import 'package:ct_social/core/database/core/hive_types.dart';
import 'package:ct_social/core/database/core/model/hive_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: HiveTypes.userModelId)
@immutable
final class UserModel with EquatableMixin, HiveModelMixin {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? password;
  @HiveField(4)
  final String? image;
  @override
  List<Object?> get props => [id, name, email, password, image];

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }

  @override
  String get boxKey => id.toString();
}
