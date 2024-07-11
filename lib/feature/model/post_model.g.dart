// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 0;

  @override
  PostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModel(
      title: fields[0] as String?,
      header: fields[1] as String?,
      bodyImage: fields[2] as Uint8List?,
      body: fields[3] as String?,
      user: fields[4] as UserModel,
      postTime: fields[5] as DateTime?,
      comments: (fields[6] as List?)?.cast<CommentModel?>(),
      likes: (fields[7] as List?)?.cast<UserModel>(),
      id: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.header)
      ..writeByte(2)
      ..write(obj.bodyImage)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.user)
      ..writeByte(5)
      ..write(obj.postTime)
      ..writeByte(6)
      ..write(obj.comments)
      ..writeByte(7)
      ..write(obj.likes)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      title: json['title'] as String?,
      header: json['header'] as String?,
      bodyImage:
          const Uint8ListConverter().fromJson(json['bodyImage'] as List<int>?),
      body: json['body'] as String?,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      postTime: json['postTime'] == null
          ? null
          : DateTime.parse(json['postTime'] as String),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'title': instance.title,
      'header': instance.header,
      'bodyImage': const Uint8ListConverter().toJson(instance.bodyImage),
      'body': instance.body,
      'user': instance.user,
      'postTime': instance.postTime?.toIso8601String(),
      'comments': instance.comments,
      'likes': instance.likes,
      'id': instance.id,
    };
