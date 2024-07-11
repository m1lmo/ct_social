import 'package:ct_social/core/database/core/hive_manager_mixin.dart';
import 'package:ct_social/core/database/core/model/hive_model.dart';

class HiveDatabaseOperation<T extends HiveModelMixin> with HiveManagerMixin<T> {
  Future<void> addOrUpdateItem(T model) => box.put(model.boxKey, model);
  T? getItems(String key) => box.get(key);
}
