import 'dart:developer' as developer;

/// Log lỗi luồng chat ra console / DevTools — tìm dòng `[CHAT_DEBUG]` để copy full.
void logChatError(String context, Object error, [StackTrace? stackTrace]) {
  final buf = StringBuffer()
    ..writeln('========== [CHAT_DEBUG] $context ==========')
    ..writeln(error)
    ..writeln('--- stack trace ---');
  if (stackTrace != null) {
    buf.writeln(stackTrace);
  } else {
    buf.writeln('(no stack trace)');
  }
  buf.writeln('========== [CHAT_DEBUG] end ==========');
  final text = buf.toString();
  developer.log(text, name: 'CHAT_DEBUG', level: 1000);
  // ignore: avoid_print
  print(text);
}
