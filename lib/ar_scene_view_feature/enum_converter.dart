import 'package:json_annotation/json_annotation.dart';

import 'light_estimation_mode.dart';

class LightEstimationModeConverter implements JsonConverter<LightEstimationMode,int>{

  const LightEstimationModeConverter();

  @override
  LightEstimationMode fromJson(json) {
    return LightEstimationMode.values[json];
  }

  @override
  int toJson(LightEstimationMode object) {
    return object.index;
  }

}