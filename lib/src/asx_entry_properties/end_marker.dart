import 'package:equatable/equatable.dart';

/// End marker of the media item.
class EndMarker extends Equatable {
  /// The number of a numeric marker in the index.
  ///
  /// The default value is the end of the content.
  final String? number;

  /// The name of a named marker in the index.
  ///
  /// The default value is the end of the content.
  final String? name;

  /// Creates EndMarker.
  EndMarker({this.name, this.number});

  @override
  List<Object?> get props => [number, name];
}
