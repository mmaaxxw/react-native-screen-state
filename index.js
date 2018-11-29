import {NativeModules, Platform, DeviceEventEmitter} from 'react-native';

const {RNScreenState} = NativeModules;

var isRegistered = false;
var _listener = null;

module.exports = {
  register(listener) {
    if (Platform.OS === 'ios') {
      return;
    }
    if (!isRegistered) {
      RNScreenState.register();
      _listener = listener;
      DeviceEventEmitter.addListener('screenStateDidChange', _listener);
      isRegistered = true;
    }
  },

  unregister() {
    if (Platform.OS === 'ios') {
      return;
    }
    if (isRegistered) {
      DeviceEventEmitter.removeListener('screenStateDidChange', _listener);
      RNScreenState.unregister();
      isRegistered = false;
    }
  }
}
