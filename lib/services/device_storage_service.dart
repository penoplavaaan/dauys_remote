import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/device_model.dart';

class DeviceStorageService {
  static const String _key = 'connected_devices';

  Future<void> saveDevice(Device device) async {
    final prefs = await SharedPreferences.getInstance();
    final devices = await getDevices();
    
    // Находим индекс существующего устройства
    final existingIndex = devices.indexWhere((d) => d.id == device.id);
    
    if (existingIndex >= 0) {
      // Если устройство существует, обновляем время подключения
      devices[existingIndex] = device;
    } else {
      // Если устройства нет, добавляем его
      devices.add(device);
    }
    
    final jsonList = devices.map((d) => d.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<List<Device>> getDevices() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];

    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((json) => Device.fromJson(json)).toList();
  }

  Future<void> removeDevice(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final devices = await getDevices();
    devices.removeWhere((d) => d.id == deviceId);
    final jsonList = devices.map((d) => d.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }
} 