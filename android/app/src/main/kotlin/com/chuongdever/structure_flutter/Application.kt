//package com.djamware.myflutter
//
//import io.flutter.app.FlutterApplication
//import io.flutter.plugin.common.PluginRegistry
//import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
//import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
//
//class Application : FlutterApplication(), PluginRegistrantCallback {
//    @Override
//    fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingService.setPluginRegistrant(this)
//    }
//
//    @Override
//    fun registerWith(registry: PluginRegistry?) {
//        FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
//    }
//}