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
      }
      isRegistered = true;
    }
    if(Platform.OS === 'ios' && sub === null){
      sub = screenStateEmitter.addListener('screenStateDidChange', _listener);
    }
  },

  unregister(){
    if(isRegistered){
      if(Platform.OS !== 'ios'){
        DeviceEventEmitter.removeListener('screenStateDidChange', _listener);
        RNScreenState.unregister();
        isRegistered = false;
      } else {
        if(sub){
          sub.remove();
          sub = null;
        }
      }
    }
  }
}
