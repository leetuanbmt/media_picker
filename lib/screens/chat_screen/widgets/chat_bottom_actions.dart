part of '../chat_screen.dart';

class ChatBottomActions extends StatelessWidget {
  const ChatBottomActions({
    super.key,
    this.onDeleted,
    this.onShare,
  });
  final VoidCallback? onDeleted, onShare;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Wrap(
        children: [
          Center(
            child: Container(
              height: 5.h,
              width: 80.w,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark_border),
            title: const Text('Save post'),
            onTap: () {
              Navigator.maybePop(context);
              onShare?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.circle_notifications),
            title: const Text('Turn on notification'),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {
              Navigator.maybePop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.maybePop(context);
              onDeleted?.call();
            },
          ),
        ],
      ),
    );
  }
}
