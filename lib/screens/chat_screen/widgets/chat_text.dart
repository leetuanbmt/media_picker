part of '../chat_screen.dart';

class ChatTextWidget extends StatelessWidget {
  const ChatTextWidget(this.message, {super.key});
  final Message message;
  @override
  Widget build(BuildContext context) {
    final style = context.bodyMedium;
    return ParsedText(
      text: message.message,
      style: context.bodyMedium,
      parse: [
        MatchText(
          pattern: tagPattern,
          style: style?.copyWith(color: context.primary),
          renderText: renderTextTagUser,
          onTap: (String str) {
            final match = customRegExp.firstMatch(str)!;
            context.toast("User ${match[2]}");
          },
        ),
        MatchText(
          type: ParsedType.EMAIL,
          style: style?.copyWith(color: Colors.blue),
          onTap: (String email) {
            context.toast("Email $email");
          },
        ),
        MatchText(
          type: ParsedType.URL,
          style: style?.copyWith(color: Colors.blue),
          onTap: (String url) {
            context.toast("Url $url");
          },
        ),
        MatchText(
          type: ParsedType.PHONE,
          style: style?.copyWith(color: Colors.amber),
          onTap: (String phone) {
            context.toast("Phone $phone");
          },
        ),
        MatchText(
          pattern: r"\B#+([\w]+)\b",
          style: style?.copyWith(color: Colors.indigo),
          onTap: (String tag) {
            context.toast("Tag $tag");
          },
        ),
      ],
    );
  }

  Map<String, String> renderTextTagUser({
    required String str,
    required String pattern,
  }) {
    final match = customRegExp.firstMatch(str)!;
    return {
      'value': match[0] ?? '',
      'display': match[1]!,
    };
  }
}
