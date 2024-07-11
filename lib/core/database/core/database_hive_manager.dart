import 'package:ct_social/core/database/core/hive_types.dart';
import 'package:ct_social/feature/model/comment_model.dart';
import 'package:ct_social/feature/model/post_model.dart';
import 'package:ct_social/feature/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Database manager for start and register adapter
/// u should call this class in main.dart
final class DatabaseHiveManager {
  Future<void> start() async {
    await _open();
    await _registerAdapter();
  }

  Future<void> _open() => Hive.initFlutter();
  Future<void> _registerAdapter() async {
    if (Hive.isAdapterRegistered(HiveTypes.userModelId)) return;
    Hive.registerAdapter(UserModelAdapter());
    if (Hive.isAdapterRegistered(HiveTypes.commentModelId)) return;
    Hive.registerAdapter(CommentModelAdapter());
    if (Hive.isAdapterRegistered(HiveTypes.postModelId)) return;
    Hive.registerAdapter(PostModelAdapter());
  }
}
