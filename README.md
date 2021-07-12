# asx

asx is a lightweight library for parsing asx files.

## Installation

Import the library into your Dart code using:

```dart
import 'package:asx/asx.dart';
```

## Usage

```dart

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

  final AsxDocument asxDocument = AsxDocument.parse(fileString);

  final List<ASXEntry>? asxEntries = asxDocument.entries;

  for (ASXEntry asxEntry in asxEntries!) {
      // Link: http://example.mp3, Title:  example | FM, Author: author
      print("Link: ${asxEntry.link}, Title: ${asxEntry.title}, Author: ${asxEntry.author}");
    }

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)