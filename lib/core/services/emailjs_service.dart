import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailJsService {
  static const String _endpoint =
      'https://formsubmit.co/ajax/ahmedwh0011@gmail.com';

  static Future<EmailResult> sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'name': name,
              'email': email,
              '_subject': subject,
              'message': message,
              '_replyto': email,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return const EmailResult(
          success: true,
          message: 'Thank you! Your message has been sent successfully.',
        );
      } else {
        return const EmailResult(
          success: false,
          message:
              'Unable to send message directly. Please use the email link below.',
        );
      }
    } catch (_) {
      return const EmailResult(
        success: false,
        message:
            'Network issue. You can reach out directly via the email link below.',
      );
    }
  }
}

class EmailResult {
  final bool success;
  final String message;

  const EmailResult({required this.success, required this.message});
}
