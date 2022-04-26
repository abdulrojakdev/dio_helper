class APiKey {
  APiKey._();

  static late final APiKey instance = APiKey._();

  String? baseUrl;

  static set baseUrlKey(String value) {
    if (value == instance.baseUrl) {
      return;
    }
    instance.baseUrl = value;
  }

  /// Retrieves the publishable API key.
  static String get baseUrlKey {
    assert(instance.baseUrl != null,
    'A publishableKey is required and missing');
    return instance.baseUrl!;
  }
}