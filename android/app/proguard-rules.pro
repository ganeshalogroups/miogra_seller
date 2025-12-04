-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
