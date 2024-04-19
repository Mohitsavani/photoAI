package com.app.posteriya.ai.generator;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        // TODO: Register the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTile",
                new com.app.posteriya.ai.generator.NativeAdFactorySmall(getContext()));
        GoogleMobileAdsPlugin.registerNativeAdFactory(flutterEngine, "listTileMedium",
                new com.app.posteriya.ai.generator.NativeAdFactoryMedium(getContext()));
    }

    @Override
    public void cleanUpFlutterEngine(FlutterEngine flutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine);

        // TODO: Unregister the ListTileNativeAdFactory
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTile");
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium");
    }
}
