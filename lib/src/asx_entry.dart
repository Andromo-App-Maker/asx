import 'asx_entry_properties/banner.dart';
import 'asx_entry_properties/end_marker.dart';
import 'asx_entry_properties/param.dart';
import 'asx_entry_properties/start_marker.dart';

/// ASX entry that specifies media file.
class AsxEntry {
  /// URL to a metafile.
  final String? link;

  /// A text string specifying the title for entry element.
  final String? title;

  /// Name of the author.
  final String? author;

  /// Text that describes the associated entry element.
  final String? abstract;

  /// Text that specifies the copyright information for an entry element.
  final String? copyright;

  /// A graphic file of the media item.
  final Banner? banner;

  /// The string appended to the front to URLs sent to Windows Media Player.
  final String? baseURL;

  /// A length of time, in hours, minutes, seconds, and hundredths of a second.
  ///
  /// Uses the following format: `"hh:mm:ss.fract"`.
  final String? duration;

  /// A length of time that the media item plays in preview mode.
  ///
  /// The duration is provided in hours, minutes, seconds,
  /// and hundredths of a second (`"hh:mm:ss.fract"`).
  final String? previewDuration;

  /// Start time of the media item.
  ///
  /// The time is provided in hours, minutes, seconds,
  /// and hundredths of a second (`"hh:mm:ss.fract"`).
  final String? startTime;

  /// End time of the media item.
  ///
  /// The time is provided in hours, minutes, seconds,
  /// and hundredths of a second (`"hh:mm:ss.fract"`).
  final String? endTime;

  /// Custom parameters associated with the element of a playlist.
  final List<Param>? params;

  /// A URL to a website, email address, or script command associated
  /// with a show, clip, or banner.
  final String? moreInfo;

  /// Start marker of the media item.
  final StartMarker? startMarker;

  /// End marker of the media item.
  final EndMarker? endMarker;

  /// Creates ASX entry that specifies media file.
  AsxEntry({
    this.title,
    this.link,
    this.author,
    this.endMarker,
    this.startMarker,
    this.moreInfo,
    this.abstract,
    this.duration,
    this.params,
    this.banner,
    this.baseURL,
    this.copyright,
    this.endTime,
    this.previewDuration,
    this.startTime,
  });
}
