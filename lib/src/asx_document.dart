library asx;

import 'package:asx/src/asx_entry.dart';
import 'package:xml/xml.dart';

import 'asx_entry_properties/banner.dart';
import 'asx_entry_properties/end_marker.dart';
import 'asx_entry_properties/param.dart';
import 'asx_entry_properties/start_marker.dart';

/// ASX document.
class AsxDocument {
  /// List of [AsxEntry].
  final List<AsxEntry>? entries;

  /// Creates [AsxEntry] from a list of [AsxEntry].
  AsxDocument({this.entries});

  /// Parses ASX document from a string.
  factory AsxDocument.parse(String documentString) {
    List<AsxEntry> values = [];

    final XmlDocument? document = XmlDocument.parse(documentString);

    final entries = document?.findAllElements('ENTRY').toList();

    if (entries != null) {
      for (XmlElement element in entries) {
        String? link;
        String? title;
        String? author;
        String? abstract;
        String? copyright;
        Banner? banner;
        String? baseURL;
        String? duration;
        String? previewDuration;
        String? startTime;
        String? endTime;
        List<Param> params = [];
        String? moreInfo;
        StartMarker? startMarker;
        EndMarker? endMarker;

        // Get Link.
        final XmlElement? ref = element.getElement("REF");
        link = ref?.getAttributeNode("HREF")?.value;

        // Get Title.
        final XmlElement? titleElement = element.getElement("TITLE");
        title = titleElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get author.
        final XmlElement? authorElement = element.getElement("AUTHOR");
        author = authorElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get abstract.
        final XmlElement? abstractElement = element.getElement("ABSTRACT");
        abstract = abstractElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get copyright.
        final XmlElement? copyrightElement = element.getElement("COPYRIGHT");
        copyright = copyrightElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get banner.
        banner = _getBanner(element);

        // Get baseURL.
        final XmlElement? baseElement = element.getElement("BASE");
        baseURL = baseElement?.getAttributeNode("HREF")?.value;

        // Get duration.
        final XmlElement? durationElement = element.getElement("DURATION");
        duration = durationElement?.getAttributeNode("VALUE")?.value;

        // Get previewDuration.
        final XmlElement? previewDurationElement =
            element.getElement("PREVIEWDURATION");
        previewDuration =
            previewDurationElement?.getAttributeNode("VALUE")?.value;

        // Get startTime.
        final XmlElement? startTimeElement = element.getElement("STARTTIME");
        startTime = startTimeElement?.getAttributeNode("VALUE")?.value;

        // Get endTime.
        final XmlElement? endTimeElement = element.getElement("ENDTIME");
        endTime = endTimeElement?.getAttributeNode("VALUE")?.value;

        // Get params.
        final List<XmlElement>? entryParams =
            element.findAllElements('PARAM').toList();

        if (entryParams != null) {
          for (XmlElement paramElement in entryParams) {
            Param param = _getParam(paramElement);

            params.add(param);
          }
        }

        // Get moreInfo.
        final XmlElement? moreInfoElement = element.getElement("MOREINFO");
        moreInfo = moreInfoElement?.getAttributeNode("HREF")?.value;

        // Get startMarker.
        startMarker = _getStartMarker(element);

        // Get endMarker.
        endMarker = _getEndMarker(element);

        values.add(AsxEntry(
          link: link,
          title: title,
          author: author,
          abstract: abstract,
          copyright: copyright,
          banner: banner,
          baseURL: baseURL,
          duration: duration,
          previewDuration: previewDuration,
          startTime: startTime,
          endTime: endTime,
          params: params,
          moreInfo: moreInfo,
          startMarker: startMarker,
          endMarker: endMarker,
        ));
      }
    }

    return AsxDocument(
      entries: values,
    );
  }

  static Banner _getBanner(XmlElement element) {
    final XmlElement? bannerElement = element.getElement("BANNER");

    String? bannerLink;
    String? bannerAbstract;
    String? bannerMoreInfoLink;

    bannerLink = bannerElement?.getAttributeNode("HREF")?.value;

    final XmlElement? bannerAbstractElement =
        bannerElement?.getElement("ABSTRACT");
    bannerAbstract = bannerAbstractElement?.descendants
        .where((node) => node is XmlText && node.text.trim().isNotEmpty)
        .join('\n');

    final XmlElement? bannerMoreInfoElement =
        bannerElement?.getElement("MOREINFO");
    bannerMoreInfoLink = bannerMoreInfoElement?.getAttributeNode("HREF")?.value;

    return Banner(
      url: bannerLink,
      moreInfo: bannerMoreInfoLink,
      abstract: bannerAbstract,
    );
  }

  static Param _getParam(XmlElement element) {
    String? paramName;
    String? paramValue;

    paramName = element.getAttributeNode("NAME")?.value;
    paramValue = element.getAttributeNode("VALUE")?.value;

    return Param(name: paramName, value: paramValue);
  }

  static StartMarker _getStartMarker(XmlElement element) {
    final XmlElement? startMarkerElement = element.getElement("STARTMARKER");

    String? startMarkerNumber;
    String? startMarkerName;

    startMarkerNumber = startMarkerElement?.getAttributeNode("NUMBER")?.value;
    startMarkerName = startMarkerElement?.getAttributeNode("NAME")?.value;

    return StartMarker(name: startMarkerName, number: startMarkerNumber);
  }

  static EndMarker _getEndMarker(XmlElement element) {
    final XmlElement? endMarkerElement = element.getElement("ENDMARKER");

    String? endMarkerNumber;
    String? endMarkerName;

    endMarkerNumber = endMarkerElement?.getAttributeNode("NUMBER")?.value;
    endMarkerName = endMarkerElement?.getAttributeNode("NAME")?.value;

    return EndMarker(name: endMarkerName, number: endMarkerNumber);
  }
}
