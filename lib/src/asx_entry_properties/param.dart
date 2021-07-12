import 'package:equatable/equatable.dart';

/// Defines a custom parameter associated with the element of a playlist.
class Param extends Equatable {
  /// Name used to access the parameter value.
  final String? name;

  /// String value associated with this parameter.
  final String? value;

  /// Creates Param.
  Param({this.name, this.value});

  @override
  List<Object?> get props => [value, name];
}
