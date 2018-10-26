
package com.reactlibrary;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.res.Configuration;
import android.util.Log;
import android.util.Property;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

public class RNScreenStateModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;
  final BroadcastReceiver receiver;
  private boolean isScreenOn = true;

  public RNScreenStateModule(final ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    receiver = new BroadcastReceiver() {
      @Override
      public void onReceive(Context context, Intent intent) {
        Log.d("TSSleepModule", "screen off/on receive");

        WritableMap params = Arguments.createMap();
        params.putBoolean("isScreenOn", intent.getAction().equals(Intent.ACTION_SCREEN_ON));
        params.putString("action", intent.getAction());
        if (reactContext.hasActiveCatalystInstance()) {
          reactContext
              .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
              .emit("screenStateDidChange", params);
        }
      }
    };
  }

  @Override
  public String getName() {
    return "RNScreenState";
  }

    @ReactMethod
    public void register(){
      final Activity activity = getCurrentActivity();
      if(activity == null){
        Log.d("TSSleepModule", "registerReceiver activity is null");
        return;
      }
      try {
        IntentFilter filter = new IntentFilter(Intent.ACTION_SCREEN_ON);
        filter.addAction(Intent.ACTION_SCREEN_OFF);
        activity.registerReceiver(receiver, filter);
      } catch (Exception e){
        Log.d("TSSleepModule", "registerReceiver exception");
        return;
      }
      Log.d("TSSleepModule", "unregisterReseiver success");
    }

    @ReactMethod
    public void unregister(){
      Log.d("TSSleepModule", "unregisterReseiver");
      final Activity activity = getCurrentActivity();
      if (activity == null) {
        Log.d("TSSleepModule", "unregisterReseiver activity is null");
        return;
      }
      try
      {
        activity.unregisterReceiver(receiver);
      }
      catch (java.lang.IllegalArgumentException e) {
        Log.d("TSSleepModule", "unregisterReseiver exception");
        return;
      }
      Log.d("TSSleepModule", "unregisterReseiver success");
    }
}

