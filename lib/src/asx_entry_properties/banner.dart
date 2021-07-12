import 'package:equatable/equatable.dart';

/// Banner defines a graphic file of the media item.
class Banner extends Equatable {
  /// A URL to a graphic file.
  final String? url;

  /// ToolTip text.
  ///
  /// This text is displayed  as a ToolTip when the user pauses the mouse
  /// pointer over the banner graphic.
  final String? abstract;

  /// A URL to which the user is taken when the user clicks the banner graphic.
  ///
  /// The URL can be any path or protocol, such as an email link,
  /// a Hypertext Transfer Protocol (HTTP) URL to a website, or even a
  /// Microsoft JScript command.
  final String? moreInfo;

  /// Creates banner.
  Banner({
    this.url,
    this.abstract,
    this.moreInfo,
  });

  @override
  List<Object?> get props => [url, abstract, moreInfo];
}
