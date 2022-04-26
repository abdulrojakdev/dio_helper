class APiCertificates {
  APiCertificates._();

  static late final APiCertificates instance = APiCertificates._();

  dynamic? certificates;

  static set certificatesApi(String value) {
    if (value == instance.certificates) {
      return;
    }
    instance.certificates = value;
  }

  /// Retrieves the publishable API certificates.
  static String get certificatesAPI {
    assert(instance.certificates != null,
    'A publishableCertificates is required and missing');
    return instance.certificates!;
  }
}