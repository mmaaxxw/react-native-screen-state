import { NativeModules, Platform, DeviceEventEmitter, NativeEventEmitter } from 'react-native';

const { RNScreenState } = NativeModules;

var isRegistered = false;
var screenStateEmitter = null;
var _listener = null;
var sub = null;
if(Platform.OS === 'ios'){
  screenStateEmitter = new NativeEventEmitter(RNScreenState)
}

module.exports = {
  register(listener){
    if(!isRegistered){
      RNScreenState.register();
      _listener = listener;
      if(Platform.OS !== 'ios'){
        DeviceEventEmitter.addListener('screenStateDidChange', _listener);
      } else {
        this.sub = screenStateEmitter.addListener('screenStateDidChange', _listener)
      }
      isRegistered = true;
    }
  },

  unregister(){
    if(isRegistered){
      RNScreenState.unregister();
      if(Platform.OS !== 'ios'){
        DeviceEventEmitter.removeListener('screenStateDidChange', _listener);
      } else {
        if(this.sub){
          this.sub.remove();
          this.sub = null;
        }
      }
      isRegistered = false;
    }
  }
}
