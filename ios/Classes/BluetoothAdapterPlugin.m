#import "BluetoothAdapterPlugin.h"
#if __has_include(<bluetooth_adapter/bluetooth_adapter-Swift.h>)
#import <bluetooth_adapter/bluetooth_adapter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "bluetooth_adapter-Swift.h"
#endif

@implementation BluetoothAdapterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBluetoothAdapterPlugin registerWithRegistrar:registrar];
}
@end
