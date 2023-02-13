package com.example.method_channel

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val methodChannelId = "CALL_METHOD"
    private val methodId = "CALL"
    private val androidViewId = "INTEGRATION_ANDROID"
    private lateinit var androidTextViewFactory: AndroidTextViewFactory
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        androidTextViewFactory = AndroidTextViewFactory(flutterEngine.dartExecutor.binaryMessenger)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(androidViewId, androidTextViewFactory)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelId).setMethodCallHandler {
            call, result ->
            if (call.method == methodId){
                androidTextViewFactory.setText(call.arguments as String)
                result.success(call.arguments)
            }
        }
    }
}
