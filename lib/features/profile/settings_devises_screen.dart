import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/core/widget/app_scaffold.dart';
import 'package:dauys_remote/features/auth/widget/auth_top_panel.dart';
import 'package:dauys_remote/features/main/widget/top_spacer.dart';
import 'package:dauys_remote/models/device_model.dart';
import 'package:dauys_remote/services/device_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';

class SettingsDevisesScreen extends StatefulWidget {
  const SettingsDevisesScreen({
    super.key,
  });

  @override
  State<SettingsDevisesScreen> createState() => SettingsDevisesScreenState();
}

class SettingsDevisesScreenState extends State<SettingsDevisesScreen> {
  final DeviceStorageService _deviceStorage = DeviceStorageService();
  List<Device> devices = [];

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    final loadedDevices = await _deviceStorage.getDevices();
    setState(() {
      devices = loadedDevices;
    });
  }

  Future<void> _removeDevice(String deviceId) async {
    await _deviceStorage.removeDevice(deviceId);
    await _loadDevices();
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
    } else {
      return DateFormat('HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      safeAreaTop: false,
      disableBackgroundColorSpots: true,
      body: Column(
        children: [
          const TopSpacer(),
          AuthTopPanel(
            title: FlutterI18n.translate(context, "settings.connected_devices"),
          ),
          const SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: devices.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      FlutterI18n.translate(context, "settings.devices.no_devices"),
                      style: AppStyles.magistral16w500.copyWith(
                        color: AppColors.white.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: devices.length,
                    itemBuilder: (context, index) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    devices[index].name,
                                    style: AppStyles.magistral16w500.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    devices[index].id,
                                    style: AppStyles.magistral12w400.copyWith(
                                      color: AppColors.white.withOpacity(.5),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    FlutterI18n.translate(context,"settings.devices.last_connection") + _formatDateTime(devices[index].connectedAt),
                                    style: AppStyles.magistral12w400.copyWith(
                                      color: AppColors.white.withOpacity(.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () => _removeDevice(devices[index].id),
                              child: Container(
                                height: 26,
                                width: 26,
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(.2),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  AppIcons.close,
                                  height: 12,
                                  width: 12,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (_, __) => Container(
                      height: 1,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 20),
                      color: AppColors.white.withOpacity(.2),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
