package com.bg.biggee
import android.content.Intent
import android.view.View
import android.widget.Toast
import androidx.annotation.Nullable
import androidx.core.net.toFile
import com.snap.camerakit.support.app.CameraActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File


class MainActivity : FlutterFragmentActivity() {

    private val CAMERAKIT_GROUP_ID = "f0659550-2788-42f7-b1f9-73d2874fd8cc" 
    private val CAMERAKIT_API_TOKEN = "eyJhbGciOiJIUzI1NiIsImtpZCI6IkNhbnZhc1MyU0hNQUNQcm9kIiwidHlwIjoiSldUIn0.eyJhdWQiOiJjYW52YXMtY2FudmFzYXBpIiwiaXNzIjoiY2FudmFzLXMyc3Rva2VuIiwibmJmIjoxNjg5NTkwMDIwLCJzdWIiOiJiNjA0NWI1Yy0wNWM4LTRmZmEtYTc2Ny1mZWQzMDQ3NjUyZDF-UFJPRFVDVElPTn4zNDI1MzNlMS1mYjJhLTQ5ZWItYmIxZC04MTJjNjgyYThmY2YifQ.5pg8en1pHrZH-Fafs-4O6Bne2bEICBgxqio6ogkueLk" 
    private val CHANNEL = "com.camerakit.flutter.sample.simple"
    

    private lateinit var _result: MethodChannel.Result
    private lateinit var _methodChannel: MethodChannel

    private val captureLauncher =
        (this as FlutterFragmentActivity).registerForActivityResult(CameraActivity.Capture) { captureResult ->
            when (captureResult) {
                is CameraActivity.Capture.Result.Success.Video -> {
                    _result.success(hashMapOf("path" to captureResult.uri.toFile().absolutePath.toString(),
                        "mime_type" to "video"))
                }
                is CameraActivity.Capture.Result.Success.Image -> {
                    _result.success(hashMapOf("path" to captureResult.uri.toFile().absolutePath.toString(),
                        "mime_type" to "image"))
                }
                is CameraActivity.Capture.Result.Cancelled -> {
                    Toast.makeText(this@MainActivity, "Action cancelled", Toast.LENGTH_SHORT).show()
                    _result.error("Cancelled", "Action Cancelled", null)
                }
                is CameraActivity.Capture.Result.Failure -> {
                    Toast.makeText(this@MainActivity, "Action failed", Toast.LENGTH_SHORT).show()
                    _result.error("Failure", "Action failed", null)
                }
            }
        }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        _methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        _methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "openCameraKitLenses") {
                _result = result
                captureLauncher.launch(
                    CameraActivity.Configuration.WithLenses(
                        cameraKitApiToken = CAMERAKIT_API_TOKEN,
                        lensGroupIds = arrayOf(CAMERAKIT_GROUP_ID)
                    )
                )
            } else {
                result.notImplemented()
            }
        }
    }
}
