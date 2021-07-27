import 'package:asx/asx.dart';

class MediaItem {

  final String? link;

  final String? title;

  final String? author;

  MediaItem({this.author, this.title, this.link});

  @override
  String toString() {
    return "MediaItem(link: $link, title: $title, author: $author)";
  }
}

void main() async {
  List<MediaItem> mediaItems = [];

  final String fileString = """
        <ASX Version="3">
     <ABSTRACT>Powered by example.com</ABSTRACT>
     <entry>
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
     </entry>
     </ASX>
  """;

  final AsxDocument asxDocument = AsxDocument.parse(fileString);

  final List<AsxEntry>? asxEntries = asxDocument.entries;

  for (AsxEntry asxEntry in asxEntries!) {
    mediaItems.add(MediaItem(
      link: asxEntry.link,
      title: asxEntry.title,
      author: asxEntry.author,
    ));
  }
  // [MediaItem(link: http://example.mp3, title:  example | FM, author: author)]
  print(mediaItems);
}
