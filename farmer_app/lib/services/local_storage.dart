import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const String boxName = 'smart_farmer_data';

  static Future<Box> _openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }

    return await Hive.openBox(boxName);
  }

  static Future<void> saveData(
    String key,
    dynamic value,
  ) async {
    final box = await _openBox();
    await box.put(key, value);
  }

  static Future<dynamic> getData(
    String key,
  ) async {
    final box = await _openBox();
    return box.get(key);
  }

  static Future<void> deleteData(
    String key,
  ) async {
    final box = await _openBox();
    await box.delete(key);
  }

  static Future<void> clearData() async {
    final box = await _openBox();
    await box.clear();
  }

  static Future<bool> containsData(
    String key,
  ) async {
    final box = await _openBox();
    return box.containsKey(key);
  }
}