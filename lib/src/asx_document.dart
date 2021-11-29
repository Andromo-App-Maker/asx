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

    List<XmlElement> entries =
        document?.findAllElements('ENTRY').toList() ?? [];

    if (entries.isEmpty) {
      entries = document?.findAllElements('entry').toList() ?? [];
    }

    if (entries.isNotEmpty) {
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
        XmlElement? ref = element.getElement("REF");

        ref ??= element.getElement("ref");

        link = ref?.getAttributeNode("HREF")?.value;

        link ??= ref?.getAttributeNode("href")?.value;

        if (link == null) {
          throw Exception("link can not be parsed");
        }

        // Get Title.
        XmlElement? titleElement = element.getElement("TITLE");

        titleElement ??= element.getElement("title");

        title = titleElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get author.
        XmlElement? authorElement = element.getElement("AUTHOR");

        authorElement ??= element.getElement("author");

        author = authorElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get abstract.
        XmlElement? abstractElement = element.getElement("ABSTRACT");

        abstractElement ??= element.getElement("abstract");

        abstract = abstractElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get copyright.
        XmlElement? copyrightElement = element.getElement("COPYRIGHT");

        copyrightElement ??= element.getElement("copyright");

        copyright = copyrightElement?.descendants
            .where((node) => node is XmlText && node.text.trim().isNotEmpty)
            .join('\n');

        // Get banner.
        banner = _getBanner(element);

        // Get baseURL.
        XmlElement? baseElement = element.getElement("BASE");

        baseElement ??= element.getElement("base");

        baseURL = baseElement?.getAttributeNode("HREF")?.value;

        baseURL ??= baseElement?.getAttributeNode("href")?.value;

        // Get duration.
        XmlElement? durationElement = element.getElement("DURATION");

        durationElement ??= element.getElement("duration");

        duration = durationElement?.getAttributeNode("VALUE")?.value;

        duration ??= durationElement?.getAttributeNode("value")?.value;

        // Get previewDuration.
        XmlElement? previewDurationElement =
            element.getElement("PREVIEWDURATION");

        previewDurationElement ??= element.getElement("previewduration");

        previewDuration =
            previewDurationElement?.getAttributeNode("VALUE")?.value;

        previewDuration ??=
            previewDurationElement?.getAttributeNode("value")?.value;

        // Get startTime.
        XmlElement? startTimeElement = element.getElement("STARTTIME");

        startTimeElement ??= element.getElement("starttime");

        startTime = startTimeElement?.getAttributeNode("VALUE")?.value;

        startTime ??= startTimeElement?.getAttributeNode("value")?.value;

        // Get endTime.
        XmlElement? endTimeElement = element.getElement("ENDTIME");

        endTimeElement ??= element.getElement("endtime");

        endTime = endTimeElement?.getAttributeNode("VALUE")?.value;

        endTime ??= endTimeElement?.getAttributeNode("value")?.value;

        // Get params.
        List<XmlElement> entryParams =
            element.findAllElements('PARAM').toList();

        if (entryParams.isEmpty) {
          entryParams = element.findAllElements('param').toList();
        }

        if (entryParams.isNotEmpty) {
          for (XmlElement paramElement in entryParams) {
            Param param = _getParam(paramElement);

            params.add(param);
          }
        }

        // Get moreInfo.
        XmlElement? moreInfoElement = element.getElement("MOREINFO");

        moreInfoElement ??= element.getElement("moreinfo");

        moreInfo = moreInfoElement?.getAttributeNode("HREF")?.value;

        moreInfo ??= moreInfoElement?.getAttributeNode("href")?.value;

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
    XmlElement? bannerElement = element.getElement("BANNER");

    bannerElement ??= element.getElement("banner");

    String? bannerLink;
    String? bannerAbstract;
    String? bannerMoreInfoLink;

    bannerLink = bannerElement?.getAttributeNode("HREF")?.value;

    bannerLink ??= bannerElement?.getAttributeNode("href")?.value;

    XmlElement? bannerAbstractElement = bannerElement?.getElement("ABSTRACT");

    bannerAbstractElement ??= bannerElement?.getElement("abstract");

    bannerAbstract = bannerAbstractElement?.descendants
        .where((node) => node is XmlText && node.text.trim().isNotEmpty)
        .join('\n');

    XmlElement? bannerMoreInfoElement = bannerElement?.getElement("MOREINFO");

    bannerMoreInfoElement ??= bannerElement?.getElement("moreinfo");

    bannerMoreInfoLink = bannerMoreInfoElement?.getAttributeNode("HREF")?.value;

    bannerMoreInfoLink ??=
        bannerMoreInfoElement?.getAttributeNode("href")?.value;

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

    paramName ??= element.getAttributeNode("name")?.value;

    paramValue = element.getAttributeNode("VALUE")?.value;

    paramValue ??= element.getAttributeNode("value")?.value;

    return Param(name: paramName, value: paramValue);
  }

  static StartMarker _getStartMarker(XmlElement element) {
    XmlElement? startMarkerElement = element.getElement("STARTMARKER");

    startMarkerElement ??= element.getElement("startmarker");

    String? startMarkerNumber;
    String? startMarkerName;

    startMarkerNumber = startMarkerElement?.getAttributeNode("NUMBER")?.value;

    startMarkerNumber ??= startMarkerElement?.getAttributeNode("number")?.value;

    startMarkerName = startMarkerElement?.getAttributeNode("NAME")?.value;

    startMarkerName ??= startMarkerElement?.getAttributeNode("name")?.value;

    return StartMarker(name: startMarkerName, number: startMarkerNumber);
  }

  static EndMarker _getEndMarker(XmlElement element) {
    XmlElement? endMarkerElement = element.getElement("ENDMARKER");

    endMarkerElement ??= element.getElement("endmarker");

    String? endMarkerNumber;
    String? endMarkerName;

    endMarkerNumber = endMarkerElement?.getAttributeNode("NUMBER")?.value;

    endMarkerNumber ??= endMarkerElement?.getAttributeNode("number")?.value;

    endMarkerName = endMarkerElement?.getAttributeNode("NAME")?.value;

    endMarkerName ??= endMarkerElement?.getAttributeNode("name")?.value;

    return EndMarker(name: endMarkerName, number: endMarkerNumber);
  }
}
