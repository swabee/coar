import 'package:hive/hive.dart';

class LocalStorage {
  static const String _currentLanguageKey = 'currentLanguage';
  void storeValue(String boxName, String id, dynamic value) {
    // final box = await Hive.openBox(boxName);
    Hive.box(boxName).put(id, value);
  }

  List<dynamic> getAllValues(String boxName) {
    // final box = await Hive.openBox(boxName);
    return Hive.box(boxName).values.toList();
  }

  Future<void> openBoxes() async {
    await Hive.openBox('driver-requests');
    await Hive.openBox('Lan');
  }

  void setCurrentLanguage(String language) {
    storeValue('Lan', _currentLanguageKey, language);
  }

  // Method to get the current language, defaults to 'Eng' if not set
  String getCurrentLanguage() {
    var storedLanguage = Hive.box('Lan').get(_currentLanguageKey);
    return storedLanguage ?? 'Eng';
  }
}
