package com.example.method_channel

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import android.webkit.*

internal class MyTextView (context: Context, id: Int, creationParams: Map<String?, Any?>?, messenger: BinaryMessenger ) : PlatformView{
    private val textView: TextView = TextView(context)
    override fun getView(): View {
        return textView
    }

    init {
        textView.text = creationParams!!["initial_text"] as String?
    }

    fun setText(newText: String){
        textView.text = newText;
    }

    override fun dispose() {}
}