import 'package:freezed_annotation/freezed_annotation.dart';

import 'plane_type.dart';
import 'pose.dart';

part 'plane.freezed.dart';

part 'plane.g.dart';

@freezed
class Plane with _$Plane {
  const factory Plane({
    @JsonEnum() PlaneType? type,
    Pose? centerPose,
  }) = _Plane;

  factory Plane.fromJson(Map<String, dynamic> json) => _$PlaneFromJson(json);
}
