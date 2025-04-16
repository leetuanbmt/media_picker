// import '../core/config.dart';
// import '../core/models/models.dart';
// import '../providers/user_provider.dart';
// import '../widgets/commons/indicators/loading_manager.dart';

// @RoutePage()
// class UserScreen extends ConsumerWidget {
//   const UserScreen({super.key, required this.userId});
//   final int userId;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userAsync = ref.watch(userProvider(userId.toString()));
//     return Scaffold(
//       appBar: AppBar(
//         systemOverlayStyle: AppTheme.lightStatusBar,
//         title: const Text('User Screen'),
//       ),
//       body: SafeArea(
//         child: userAsync.when(
//           data: (data) => GestureDetector(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 100,
//                     backgroundImage: NetworkImage(data.avatar),
//                   ),
//                   Text(data.name),
//                   Text(data.email),
//                 ],
//               ),
//             ),
//             onTap: () {
//               context.nextPage(const UsersScreen());
//             },
//           ),
//           error: (error, stackTrace) => Center(
//             child: Text(error.toString()),
//           ),
//           loading: () => const Center(child: TurnLoading()),
//         ),
//       ),
//     );
//   }
// }

// class UserListScreen extends HookConsumerWidget {
//   const UserListScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final scroll = useScrollController();
//     onLoadMore() {
//       double currentScroll = scroll.position.pixels;
//       double maxScroll = scroll.position.maxScrollExtent;
//       double delta = MediaQuery.of(context).size.height * 0.25;
//       if (maxScroll - currentScroll <= delta) {
//         ref.read(userListProvider.notifier).loadMore();
//       }
//     }

//     useEffect(
//       () {
//         scroll.addListener(onLoadMore);
//         return () => scroll.removeListener(onLoadMore);
//       },
//       [scroll],
//     );
//     final userAsync = ref.watch(userListProvider);

//     final isLoadMore = userAsync.maybeWhen(
//       data: (data) => data.isLoadMore,
//       orElse: () => false,
//     );
//     return Scaffold(
//       floatingActionButton: ScrollToTopButton(scroll: scroll),
//       appBar: AppBar(
//         systemOverlayStyle: AppTheme.lightStatusBar,
//         title: const Text('List User'),
//       ),
//       body: RefreshIndicator.adaptive(
//         onRefresh: ref.read(userListProvider.notifier).onRefresh,
//         child: Column(
//           children: [
//             Expanded(
//               child: userAsync.when(
//                 data: (UserResultState data) => ListView.builder(
//                   controller: scroll,
//                   itemCount: data.data.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final user = data.data[index];
//                     return UserDetail(user: user);
//                   },
//                 ),
//                 loading: () => const Center(child: TurnLoading()),
//                 error: (error, stackTrace) => Center(
//                   child: Text(error.toString()),
//                 ),
//               ),
//             ),
//             if (isLoadMore)
//               const Center(
//                 child: CircularProgressIndicator(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UserDetail extends StatelessWidget {
//   const UserDetail({super.key, required this.user});
//   final UserModel user;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(user.avatar),
//       ),
//       title: Text(user.name),
//       subtitle: Text(user.email),
//       trailing: DecoratedBox(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.primaries[user.id % Colors.primaries.length],
//         ),
//         child: SizedBox.square(
//           dimension: 30,
//           child: Center(
//             child: Text(
//               user.id.toString(),
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//       onTap: () {
//         context.nextPage(UserScreen(userId: user.id));
//       },
//     );
//   }
// }

// class ScrollToTopButton extends StatelessWidget {
//   const ScrollToTopButton({Key? key, required this.scroll}) : super(key: key);

//   final ScrollController scroll;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: scroll,
//       builder: (context, child) {
//         if (scroll.hasClients == false) {
//           return const SizedBox.shrink();
//         }
//         double scrollOffset = scroll.offset;

//         return AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           transitionBuilder: (child, animation) {
//             return ScaleTransition(scale: animation, child: child);
//           },
//           child: scrollOffset > MediaQuery.of(context).size.height * 0.5
//               ? FloatingActionButton(
//                   tooltip: "Scroll to top",
//                   child: const Icon(
//                     Icons.arrow_upward,
//                   ),
//                   onPressed: () async {
//                     scroll.animateTo(
//                       0,
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                     );
//                   },
//                 )
//               : const SizedBox.shrink(),
//         );
//       },
//     );
//   }
// }

// class ItemList extends StatelessWidget {
//   const ItemList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final state = ref.watch(usersProvider);
//         return state.when(
//           data: (items) => ItemsListBuilder(items: items),
//           loading: () => const SliverToBoxAdapter(
//             child: TurnLoading(),
//           ),
//           error: (error) => SliverToBoxAdapter(
//             child: Center(
//               child: Text(error.toString()),
//             ),
//           ),
//           loadMore: (items) => ItemsListBuilder(items: items),
//           loadMoreError: (items, e) {
//             return SliverToBoxAdapter(
//               child: Center(
//                 child: Text(e.toString()),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class ItemsListBuilder extends StatelessWidget {
//   const ItemsListBuilder({
//     Key? key,
//     required this.items,
//   }) : super(key: key);

//   final List<UserModel> items;

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (context, index) {
//           return UserDetail(user: items[index]);
//         },
//         childCount: items.length,
//       ),
//     );
//   }
// }

// class LoadMoreWidget extends StatelessWidget {
//   const LoadMoreWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Consumer(
//         builder: (context, ref, child) {
//           return ref.watch(usersProvider).maybeWhen(
//                 loadMore: (items) => const TurnLoading(),
//                 orElse: () => Dimensions.empty,
//               );
//         },
//       ),
//     );
//   }
// }

// class UsersScreen extends HookConsumerWidget {
//   const UsersScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final scroll = useScrollController();
//     onLoadMore() {
//       double currentScroll = scroll.position.pixels;
//       double maxScroll = scroll.position.maxScrollExtent;
//       double delta = MediaQuery.of(context).size.height * 0.25;
//       if (maxScroll - currentScroll <= delta) {
//         ref.read(usersProvider.notifier).onLoadMore();
//       }
//     }

//     useEffect(
//       () {
//         scroll.addListener(onLoadMore);
//         return () => scroll.removeListener(onLoadMore);
//       },
//       [scroll],
//     );
//     return Scaffold(
//       body: CustomScrollView(
//         controller: scroll,
//         slivers: const [
//           SliverAppBar(
//             pinned: true,
//             title: Text('Users'),
//           ),
//           ItemList(),
//           LoadMoreWidget(),
//         ],
//       ),
//     );
//   }
// }
