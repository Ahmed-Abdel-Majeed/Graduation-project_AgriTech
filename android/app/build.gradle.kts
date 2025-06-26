import java.util.Properties

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.agri"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.ahmedabdalmaged.agritechx"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

signingConfigs {
    create("release") {
        val alias = keystoreProperties["keyAlias"]?.toString()
        val keyPass = keystoreProperties["keyPassword"]?.toString()
        val storePath = keystoreProperties["storeFile"]?.toString()
        val storePass = keystoreProperties["storePassword"]?.toString()

        println("Alias: $alias")
        println("KeyPass: $keyPass")
        println("StorePath: $storePath")
        println("StorePass: $storePass")

        if (alias.isNullOrEmpty() || keyPass.isNullOrEmpty() || storePath.isNullOrEmpty() || storePass.isNullOrEmpty()) {
            throw GradleException("Keystore properties are not set correctly. Please check key.properties.")
        }

        keyAlias = alias
        keyPassword = keyPass
        storeFile = file(storePath)
        storePassword = storePass
    }
}



    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
