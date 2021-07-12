import 'package:equatable/equatable.dart';

/// Start marker of the media item.
class StartMarker extends Equatable {
  /// String value of the number of a numeric marker in the index.
  ///
  /// The default value is the beginning of on-demand content or the current position in a real-time stream.
  final String? number;

  /// The name of a named marker in the index.
  ///
  /// The default value is the beginning of on-demand content or the current position in a real-time stream.
  final String? name;

  /// Creates StartMarker.
  StartMarker({this.name, this.number});

  @override
  List<Object?> get props => [number, name];
}
