import 'package:asx/asx.dart';
import 'package:test/test.dart';

void main() {

  group('Parse asx file as fileString', () {
    final String fileString = """
        <ASX Version="3">
     <ABSTRACT>Powered by example.com</ABSTRACT>
     <ENTRY>
     <REF HREF = "http://example.mp3"/>
     <ABSTRACT>Powered by example.com</ABSTRACT>
     <TITLE> example | FM</TITLE>
     <COPYRIGHT>(c) copyright </COPYRIGHT>
     <DURATION VALUE="00:00:30" />
     <AUTHOR>author</AUTHOR>
     <PREVIEWDURATION VALUE="0:30.0" />
     <PARAM NAME="Location" VALUE="North America" />
     <PARAM NAME="Release Date" VALUE="March 1998" />
     <BANNER HREF="http://example.com">
         <ABSTRACT>Click here to go to our website.</ABSTRACT>
         <MOREINFO HREF="https://sample.example.com" />
     </BANNER>
     <BASE HREF="https://sample.example.com" />
     <STARTTIME VALUE="0:10.0" />
     <MOREINFO HREF="https://sample.example.com" />
     <STARTMARKER NUMBER="14" />
     <ENDMARKER NUMBER="17" NAME="Marker_StopHere" />
     </ENTRY>
     </ASX>
  """;

    final asxParser = AsxDocument.parse(fileString);

    test('Entries not null', () {
      expect(asxParser.entries, isNotNull, reason: "Entries are null",);
    });

    test('Parses one entry', () {
      expect(asxParser.entries!.length, 1);
    });

    final AsxEntry entry = asxParser.entries![0];

    test('Parses title', () {
      expect(
        entry.title,
        ' example | FM',
        reason: "the parsed title doesn’t match the expected one",
      );
    });

    test('Parses link', () {
      expect(
        entry.link,
        'http://example.mp3',
        reason: "the parsed link doesn’t match the expected one",
      );
    });
    test('Parses author', () {
      expect(
        entry.author,
        'author',
        reason: "the parsed author doesn’t match the expected one",
      );
    });
    test('Parses endMarker', () {
      expect(
        entry.endMarker,
        EndMarker(
          number: "17",
          name: "Marker_StopHere",
        ),
        reason: "the parsed endMarker doesn’t match the expected one",
      );
    });
    test('Parses startMarker', () {
      expect(
        entry.startMarker,
        StartMarker(
          number: "14",
          name: null,
        ),
        reason: "the parsed startMarker doesn’t match the expected one",
      );
    });
    test('Parses moreInfo', () {
      expect(
        entry.moreInfo,
        'https://sample.example.com',
        reason: "the parsed moreInfo doesn’t match the expected one",
      );
    });
    test('Parses abstract', () {
      expect(
        entry.abstract,
        'Powered by example.com',
        reason: "the parsed abstract doesn’t match the expected one",
      );
    });
    test('Parses duration', () {
      expect(
        entry.duration,
        '00:00:30',
        reason: "the parsed duration doesn’t match the expected one",
      );
    });
    test('Parses params', () {
      expect(
        entry.params,
        [
          Param(name: "Location", value: "North America"),
          Param(name: "Release Date", value: "March 1998"),
        ],
        reason: "the parsed params don’t match the expected ones",
      );
    });
    test('Parses banner', () {
      expect(
        entry.banner,
        Banner(
          url: "http://example.com",
          abstract: "Click here to go to our website.",
          moreInfo: "https://sample.example.com",
        ),
        reason: "the parsed banner doesn’t match the expected one",
      );
    });

    test('Parses baseURL', () {
      expect(
        entry.baseURL,
        'https://sample.example.com',
        reason: "the parsed baseURL doesn’t match the expected one",
      );
    });
    test('Parses copyright', () {
      expect(
        entry.copyright,
        '(c) copyright ',
        reason: "the parsed copyright doesn’t match the expected one",
      );
    });
    test('Parses startTime', () {
      expect(
        entry.startTime,
        '0:10.0',
        reason: "the parsed startTime doesn’t match the expected one",
      );
    });
    test('Parses endTime is null', () {
      expect(
        entry.endTime,
        isNull,
        reason: "the parsed endTime is not null",
      );
    });
    test('Parses previewDuration', () {
      expect(
        entry.previewDuration,
        '0:30.0',
        reason: "the parsed previewDuration doesn’t match the expected one",
      );
    });
  });

}
