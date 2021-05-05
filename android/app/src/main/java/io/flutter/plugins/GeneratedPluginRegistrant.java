package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.example.bluetooth_adapter.BluetoothAdapterPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    BluetoothAdapterPlugin.registerWith(registry.registrarFor("com.example.bluetooth_adapter.BluetoothAdapterPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
