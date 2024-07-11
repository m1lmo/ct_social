import 'package:hive/hive.dart';

mixin HiveManagerMixin<T> {
  final String _boxKey = T.toString();
  late final Box<T> box; //TODO : check if it is necessary to make it late AND FINAL
  Future<void> init() async {
    box = await Hive.openBox<T>(_boxKey);
  }
}
