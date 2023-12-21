import 'package:bloc_state_management/core/repository/user_repo.dart';
import 'package:bloc_state_management/main.dart';
import 'package:bloc_state_management/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  setUpAll(() => loadAppFonts());
  testGoldens('description', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        widget: const MyApp(),
        name: 'sc page',
      );

    //flutter test --update-goldens
    await tester.pumpDeviceBuilder(builder,
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
          platform: TargetPlatform.android,
        ));

    await screenMatchesGolden(tester, 'first_screenshot');
  });
}
