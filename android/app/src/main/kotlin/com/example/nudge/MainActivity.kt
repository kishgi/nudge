package com.example.nudge

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.nudge/launcher"
    private var methodChannel: MethodChannel? = null
    private var packageReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "getInstalledApps" -> {
                    val apps = getInstalledAppsList()
                    result.success(apps)
                }
                "launchApp" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        val success = launchApplication(packageName)
                        if (success) {
                            result.success(null)
                        } else {
                            result.error("LAUNCH_FAILED", "Could not launch app: $packageName", null)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Package name is null", null)
                    }
                }
                "hasUsageStatsPermission" -> {
                    result.success(hasUsageStatsPermission())
                }
                "requestUsageStatsPermission" -> {
                    requestUsageStatsPermission()
                    result.success(null)
                }
                "getAppUsageStats" -> {
                    val startTime = call.argument<Long>("startTime")
                    val endTime = call.argument<Long>("endTime")
                    if (startTime != null && endTime != null) {
                        result.success(getAppUsageStats(startTime, endTime))
                    } else {
                        result.error("INVALID_ARGUMENT", "startTime or endTime is null", null)
                    }
                }
                "hasContactsPermission" -> {
                    result.success(hasContactsPermission())
                }
                "requestContactsPermission" -> {
                    requestContactsPermission()
                    result.success(null)
                }
                "getContacts" -> {
                    result.success(getContactsList())
                }
                "dialNumber" -> {
                    val number = call.argument<String>("number")
                    if (number != null) {
                        val intent = Intent(Intent.ACTION_DIAL, android.net.Uri.parse("tel:$number"))
                        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        startActivity(intent)
                        result.success(true)
                    } else {
                        result.error("INVALID_ARGUMENT", "Number is null", null)
                    }
                }
                "lockScreen" -> {
                    val locked = tryLockScreen()
                    result.success(locked)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        registerPackageReceiver()
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterPackageReceiver()
    }

    private fun getInstalledAppsList(): List<Map<String, Any?>> {
        val pm: PackageManager = packageManager
        val mainIntent = Intent(Intent.ACTION_MAIN, null)
        mainIntent.addCategory(Intent.CATEGORY_LAUNCHER)
        
        val resolvedInfos = pm.queryIntentActivities(mainIntent, 0)
        val appsList = ArrayList<Map<String, Any?>>()

        for (info in resolvedInfos) {
            val appName = info.loadLabel(pm).toString()
            val packageName = info.activityInfo.packageName
            val iconDrawable = info.loadIcon(pm)
            val iconBytes = drawableToByteArray(iconDrawable)
            val category = resolveAppCategory(pm, packageName)

            val appMap = HashMap<String, Any?>()
            appMap["appName"] = appName
            appMap["packageName"] = packageName
            appMap["icon"] = iconBytes
            appMap["category"] = category
            appsList.add(appMap)
        }
        return appsList
    }

    /**
     * Maps Android's ApplicationInfo.category (API 26+) to a human-readable
     * string. Falls back to package-prefix heuristics on older devices.
     */
    private fun resolveAppCategory(pm: PackageManager, packageName: String): String {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            try {
                val appInfo = pm.getApplicationInfo(packageName, 0)
                val cat = ApplicationInfo.getCategoryTitle(this, appInfo.category)
                if (cat != null && cat.isNotEmpty()) return cat.toString()
            } catch (_: Exception) { }
        }
        // Package-prefix heuristics as fallback
        return when {
            packageName.contains("game") -> "Game"
            packageName.contains("music") || packageName.contains("audio") || packageName.contains("spotify") -> "Audio"
            packageName.contains("video") || packageName.contains("youtube") || packageName.contains("netflix") -> "Video"
            packageName.contains("photo") || packageName.contains("gallery") || packageName.contains("camera") -> "Image"
            packageName.contains("social") || packageName.contains("twitter") || packageName.contains("instagram") || packageName.contains("facebook") -> "Social"
            packageName.contains("news") || packageName.contains("rss") || packageName.contains("reddit") -> "News"
            packageName.contains("maps") || packageName.contains("navigation") || packageName.contains("waze") -> "Maps"
            packageName.contains("office") || packageName.contains("docs") || packageName.contains("sheet") || packageName.contains("productivity") -> "Productivity"
            else -> "Other"
        }
    }

    /**
     * Attempts to lock the screen via DevicePolicyManager.
     * Returns true if successful, false if the launcher does not have
     * BIND_DEVICE_ADMIN rights (graceful no-op).
     */
    private fun tryLockScreen(): Boolean {
        return try {
            val dpm = getSystemService(DEVICE_POLICY_SERVICE) as android.app.admin.DevicePolicyManager
            dpm.lockNow()
            true
        } catch (_: Exception) {
            false
        }
    }

    private fun launchApplication(packageName: String): Boolean {
        val pm: PackageManager = packageManager
        val launchIntent = pm.getLaunchIntentForPackage(packageName)
        return if (launchIntent != null) {
            startActivity(launchIntent)
            true
        } else {
            false
        }
    }

    private fun drawableToByteArray(drawable: Drawable): ByteArray? {
        try {
            val bitmap = when (drawable) {
                is BitmapDrawable -> drawable.bitmap
                else -> {
                    val width = if (drawable.intrinsicWidth > 0) drawable.intrinsicWidth else 1
                    val height = if (drawable.intrinsicHeight > 0) drawable.intrinsicHeight else 1
                    val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
                    val canvas = Canvas(bitmap)
                    drawable.setBounds(0, 0, canvas.width, canvas.height)
                    drawable.draw(canvas)
                    bitmap
                }
            }
            val stream = ByteArrayOutputStream()
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
            return stream.toByteArray()
        } catch (e: Exception) {
            e.printStackTrace()
            return null
        }
    }

    private fun registerPackageReceiver() {
        packageReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                runOnUiThread {
                    methodChannel?.invokeMethod("onAppsChanged", null)
                }
            }
        }
        val filter = IntentFilter().apply {
            addAction(Intent.ACTION_PACKAGE_ADDED)
            addAction(Intent.ACTION_PACKAGE_REMOVED)
            addAction(Intent.ACTION_PACKAGE_CHANGED)
            addDataScheme("package")
        }
        registerReceiver(packageReceiver, filter)
    }

    private fun unregisterPackageReceiver() {
        packageReceiver?.let {
            unregisterReceiver(it)
            packageReceiver = null
        }
    }

    private fun hasUsageStatsPermission(): Boolean {
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as android.app.AppOpsManager
        val mode = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.Q) {
            appOps.unsafeCheckOpNoThrow(android.app.AppOpsManager.OPSTR_GET_USAGE_STATS, android.os.Process.myUid(), packageName)
        } else {
            appOps.checkOpNoThrow(android.app.AppOpsManager.OPSTR_GET_USAGE_STATS, android.os.Process.myUid(), packageName)
        }
        return mode == android.app.AppOpsManager.MODE_ALLOWED
    }

    private fun requestUsageStatsPermission() {
        val intent = Intent(android.provider.Settings.ACTION_USAGE_ACCESS_SETTINGS)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }

    private fun getAppUsageStats(startTime: Long, endTime: Long): List<Map<String, Any?>> {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as android.app.usage.UsageStatsManager
        val stats = usageStatsManager.queryUsageStats(android.app.usage.UsageStatsManager.INTERVAL_DAILY, startTime, endTime)
        val result = ArrayList<Map<String, Any?>>()

        if (stats != null) {
            val mergedStats = HashMap<String, android.app.usage.UsageStats>()
            for (stat in stats) {
                val pkg = stat.packageName
                val existing = mergedStats[pkg]
                if (existing == null || stat.lastTimeUsed > existing.lastTimeUsed) {
                    mergedStats[pkg] = stat
                }
            }

            for ((pkg, stat) in mergedStats) {
                val timeInForeground = stat.totalTimeInForeground
                if (timeInForeground > 0) {
                    val map = HashMap<String, Any?>()
                    map["packageName"] = pkg
                    map["totalTimeInForeground"] = timeInForeground
                    map["lastTimeUsed"] = stat.lastTimeUsed

                    val launchCount = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.P) {
                        stat.appLaunchCount
                    } else {
                        0
                    }
                    map["launchCount"] = launchCount
                    result.add(map)
                }
            }
        }
        return result
    }

    private fun hasContactsPermission(): Boolean {
        return if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            checkSelfPermission(android.Manifest.permission.READ_CONTACTS) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }

    private fun requestContactsPermission() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            requestPermissions(arrayOf(android.Manifest.permission.READ_CONTACTS), 101)
        }
    }

    private fun getContactsList(): List<Map<String, String>> {
        val contactsList = ArrayList<Map<String, String>>()
        if (!hasContactsPermission()) return contactsList

        val resolver = contentResolver
        val cursor = resolver.query(
            android.provider.ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
            arrayOf(
                android.provider.ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME,
                android.provider.ContactsContract.CommonDataKinds.Phone.NUMBER
            ),
            null,
            null,
            null
        )

        cursor?.use {
            val nameIndex = it.getColumnIndex(android.provider.ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME)
            val numberIndex = it.getColumnIndex(android.provider.ContactsContract.CommonDataKinds.Phone.NUMBER)

            while (it.moveToNext()) {
                val name = if (nameIndex >= 0) it.getString(nameIndex) else null
                val number = if (numberIndex >= 0) it.getString(numberIndex) else null
                if (name != null) {
                    val map = HashMap<String, String>()
                    map["name"] = name
                    map["number"] = number ?: ""
                    contactsList.add(map)
                }
            }
        }
        return contactsList
    }
}
