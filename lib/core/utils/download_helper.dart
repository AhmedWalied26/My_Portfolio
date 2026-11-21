import 'download_helper_stub.dart'
    if (dart.library.html) 'download_helper_web.dart';
import '../constants/app_assets.dart';
import '../constants/app_strings.dart';

/// Directly downloads the local CV PDF file in modern browsers.
Future<void> downloadCv() async {
  await downloadCvFile(AppAssets.cvPdf, AppStrings.cvFileName);
}
