// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ct_social/core/database/operation/post_hive_operation.dart';
import 'package:ct_social/core/helper/image_upload_manager.dart';
import 'package:ct_social/feature/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ct_social/main.dart';

void main() {
  late final ImageUploadManager imageUploadManager;
  final postHiveOperation = PostHiveOperation();
  setUp(() {
    imageUploadManager = ImageUploadManager();
    postHiveOperation.init();
  });
  test('ImageUploadManager should fetch image from library', () async {
    final result = await imageUploadManager.fetchFromLibrary();
    expect(result, isNotNull);
  });
  test('post hive operation ', () async {
    final result = postHiveOperation.box.values;
    expect(result, List<PostModel?>);
  });
  // expect( , imageUploadManager.fetchFromLibrary());
}
