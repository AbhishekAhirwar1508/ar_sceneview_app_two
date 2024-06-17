import 'package:freezed_annotation/freezed_annotation.dart';

import 'plane.dart';

part 'session_frame.freezed.dart';

part 'session_frame.g.dart';

@freezed
class SessionFrame with _$SessionFrame {
  const factory SessionFrame({
    @Default([]) List<Plane> planes,
  }) = _SessionFrame;

  factory SessionFrame.fromJson(Map<String, dynamic> json) =>
      _$SessionFrameFromJson(json);
}
