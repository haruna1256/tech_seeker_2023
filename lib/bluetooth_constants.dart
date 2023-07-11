

class BluetoothConstants {
  const BluetoothConstants._();

  /// このプロジェクトのBLEのサービスのUUID
  static const String serviceUuid = "d6f19b1b-3b62-4d39-ad7d-ec2dddbeb0ee";

  /// ESP32からFlutterに送信するセンサー値のキャラクタリスティックのUUID
  static const String sensorValueCharacteristicUuid = "78b5f08c-a793-4127-9a94-85a246056038";

  /// ESP32からFlutterに部屋必要かを送信するセンサー値のキャラクタリスティックのUUID
  static const String roomNeedCharacteristicUuid = "2dff4dad-bfa5-4265-bdfc-f0d0a85dd2e0";

  /// FlutterからESP32に部屋色を送信するためのキャラクタリスティックのUUID
  static const String roomColorCharacteristicUuid = "30dfe503-7a09-4c5f-9a9f-352d773666d3";

  /// ESP32からFlutterに部屋ブザーを送信するセンサー値のキャラクタリスティックのUUID
  static const String roomBuzzerCharacteristicUuid = "14594b63-f642-4da4-bdf8-c44165677d96";

  /// ESP32からFlutterに部屋通知タイミングを送信するセンサー値のキャラクタリスティックのUUID
  static const String roomTimeCharacteristicUuid = "391c0103-9e67-47b0-9a73-a4481a1768b5";

  /// ESP32からFlutterに外必要かを送信するセンサー値のキャラクタリスティックのUUID
  static const String goNeedCharacteristicUuid = "8da3e607-bda7-42b6-8123-53b4cc9d3318";

  /// ESP32からFlutterに外通知タイミングを送信するセンサー値のキャラクタリスティックのUUID
  static const String goTimeCharacteristicUuid = "07438c11-eba9-4487-9871-87fc62fd517d";

  /// FlutterからESP32に外色を送信するためのキャラクタリスティックのUUID
  static const String goColorCharacteristicUuid = "b1b0e200-8854-4931-a1f2-08b6502be9b6";

  /// ESP32からFlutterに部屋ブザーを送信するセンサー値のキャラクタリスティックのUUID
  static const String goBuzzerCharacteristicUuid = "14594b63-f642-4da4-bdf8-c44165677d96";
/*
  /// FlutterからESP32にWiFiのSSIDを送信するためのキャラクタリスティックのUUID
  static const String wifiSsidCharacteristicUuid = "54acff26-12f7-4502-a9b4-3f82a268df08";

  /// FlutterからESP32にWiFiのパスワードを送信するためのキャラクタリスティックのUUID
  static const String wifiPasswordCharacteristicUuid = "bb11fb53-9d60-4f30-af5a-70485a572671";

  static const String wifiConnectionStatusCharacteristicUuid = "747eb891-fc27-4627-bb29-0fdca8376957";
  */
}