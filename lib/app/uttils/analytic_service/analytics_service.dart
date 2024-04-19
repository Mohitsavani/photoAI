import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService instance = AnalyticsService._internal();

  factory AnalyticsService() {
    return instance;
  }
  AnalyticsService._internal();

  Future sendAnalyticsEvent({
    required String eventName,
    Map<String, Object?>? parameters,
  }) async {
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }
}
