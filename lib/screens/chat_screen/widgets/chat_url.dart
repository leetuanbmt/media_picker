part of '../chat_screen.dart';

class ChatUrl extends StatefulWidget {
  const ChatUrl(this.message, {super.key});
  final Message message;

  @override
  State<ChatUrl> createState() => _ChartUrlState();
}

class _ChartUrlState extends State<ChatUrl> with AutomaticKeepAliveClientMixin {
  Map<String, PreviewData> map = {};

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final String messageText = widget.message.message;
    final RegExp exp =
        RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    final Iterable<RegExpMatch> urlMatches = exp.allMatches(messageText);
    final urls = urlMatches
        .map((urlMatch) => messageText.substring(urlMatch.start, urlMatch.end))
        .where((String e) => e.length >= 10)
        .toList();
    return Column(
      children: urls
          .asMap()
          .entries
          .map(
            (e) => Container(
              key: ValueKey(urls[e.key]),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Color(0xfff7f7f8),
              ),
              child: LinkPreview(
                enableAnimation: false,
                onPreviewDataFetched: (data) {
                  setState(() {
                    map[e.key.toString()] = data;
                  });
                },
                previewData: map[e.key.toString()],
                text: e.value,
                width: context.screenWidth,
                onLinkPressed: (url) {
                  _launchUrl(url);
                },
              ),
            ),
          )
          .toList(),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
