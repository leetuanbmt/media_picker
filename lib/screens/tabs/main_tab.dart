import 'dart:async';

import '../../core/config.dart';
import '../../core/hooks/configurations/use_pagination.dart';
import '../../core/models/models.dart';
import '../../core/providers/common_provider.dart';
import '../../core/utilities/pagination/pagination.dart';
import '../../widgets/commons/app_lifecycle.dart';
import '../../widgets/commons/cache_image.dart';
import '../../widgets/commons/indicators/loading_indicator.dart';
import '../../widgets/commons/indicators/loading_manager.dart';

final userNotify =
    StateNotifierProvider.autoDispose<UserNotify, PaginationState<UserM>>(
        (ref) {
  return UserNotify(ref);
});

class UserNotify extends PaginationNotifier<UserM> {
  final Ref ref;

  UserNotify(this.ref);
  @override
  FutureOr<Result<PaginationResponse<UserM>>> request(int page) async {
    return ref.watch(repositoryProvider).getUserList(page: page);
  }
}

@RoutePage()
class MainScreen extends HookConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userNotify);
    ref.listen(userNotify, (previous, next) {
      if (next is PaginationLoading) {
        LoadingManager().show(context);
      } else {
        LoadingManager().hide(context);
      }
    });
    final controller = ref.watch(userNotify.notifier);
    final scrollController = usePagination(
      controller.onLoadMore,
      () => controller.canLoadMore(),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        title: Text(
          context.lang.numberOfDataPoints(400),
          maxLines: 2,
        ),
      ),
      body: AppLifecycleWidget(
        onResumed: () {
          ref.read(userNotify.notifier).onRefresh();
        },
        child: RefreshIndicator(
          onRefresh: () async {
            return ref.read(userNotify.notifier).onRefresh();
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              state.maybeWhen(
                orElse: () => const SliverToBoxAdapter(),
                success: (items) {
                  return ItemsListBuilder(items);
                },
                loadMore: (items) {
                  return ItemsListBuilder(items);
                },
                error: (e) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(e.toString()),
                    ),
                  );
                },
              ),
              const LoadingMore(),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorWidget(Object? error) {
    return Center(
      child: Text(error.toString()),
    );
  }
}

class ItemsListBuilder extends HookConsumerWidget {
  const ItemsListBuilder(
    this.items, {
    super.key,
  });
  final List<UserM> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final user = items[index];
          return ListTile(
            leading: CacheImage(
              image: user.avatar,
              dimension: const Size.square(40),
              radius: 100,
            ),
            title: Text(user.fullName),
            subtitle: Text(user.email ?? 'Unknown'),
            trailing: Text((index + 1).toString()),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

class LoadingMore extends ConsumerWidget {
  const LoadingMore({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: ref.watch(userNotify).maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loadMore: (_) => const LoadingIndicator(),
          ),
    );
  }
}

class BaseHookConsumer extends StatefulHookConsumerWidget {
  const BaseHookConsumer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BaseHookConsumerState();
}

class _BaseHookConsumerState extends ConsumerState<BaseHookConsumer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
