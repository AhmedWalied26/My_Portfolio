import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<void> downloadCvFile(String assetPath, String suggestedFileName) async {
  try {
    final byteData = await rootBundle.load(assetPath);
    final bytes = byteData.buffer.asUint8List();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = '_blank'
      ..download = suggestedFileName;
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    Future.delayed(const Duration(seconds: 5), () {
      html.Url.revokeObjectUrl(url);
    });
    return;
  } catch (e) {
    debugPrint('Asset bundle load error: $e, falling back to direct web URL');
  }

  try {
    final anchor = html.AnchorElement(href: suggestedFileName)
      ..target = '_blank'
      ..download = suggestedFileName;
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
  } catch (e) {
    debugPrint('Direct anchor download failed: $e');
  }
}
