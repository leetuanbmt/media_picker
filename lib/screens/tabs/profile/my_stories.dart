import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/config.dart';
import '../../../core/models/models.dart';
import '../../../core/models/story/story.dart';
import '../../../core/utilities/utilities.dart';
import '../../../widgets/commons/cache_image.dart';
import '../../../widgets/commons/shimmer.dart';
import '../../story_screen/story_screen.dart';

final storyProvider = StreamProvider<List<StoryModel>>(
  (_) async* {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final collection = FirebaseFirestore.instance
        .collection(DbCollection.users)
        .doc(uid)
        .collection(DbCollection.stories)
        .orderBy(DbKeys.timestamp, descending: true);

    yield* collection.snapshots().map(
          (event) => event.docs.map((e) {
            final data = e.data();
            return StoryModel.fromJson(data).copyWith(id: e.id);
          }).toList(),
        );
  },
);

class MyStoriesScreen extends ConsumerWidget {
  const MyStoriesScreen({super.key});
  void openStory(
    BuildContext context,
    List<StoryModel> stories,
    int index,
  ) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final user = await FirebaseFirestore.instance
        .collection(DbCollection.users)
        .doc(uid)
        .get();

    final userModel = UserModel.fromJson(user.data()!);
    if (!context.mounted) return;
    StoryViewPage.openStory(
      context,
      stories: [
        StoryList(user: userModel, stories: stories),
      ],
      storyInitPage: index,
    );
  }

  void removeStoryById(String id) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection(DbCollection.users)
        .doc(uid)
        .collection(DbCollection.stories)
        .doc(id)
        .delete();
  }

  void insertStory() async {
    // FirebaseFirestore.instance
    //     .collection(DbCollection.users)
    //     .doc('y1kEuKFdz5bH6zSkLslOLhhibRo1')
    //     .collection(DbCollection.stories)
    //     .get()
    //     .then((value) {
    //   value.docs.forEach((element) {
    //     final uid = FirebaseAuth.instance.currentUser!.uid;
    //     FirebaseFirestore.instance
    //         .collection(DbCollection.users)
    //         .doc(uid)
    //         .collection(DbCollection.stories)
    //         .add(element.data());
    //   });
    // });
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final collection = FirebaseFirestore.instance
        .collection(DbCollection.users)
        .doc(uid)
        .collection(DbCollection.stories);
    await collection.add(
      StoryModel(
        author: uid,
        type: DbKeys.video,
        width: 576,
        height: 1024,
        duration: 1,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        name: '',
        thumbnail: '',
        url: '',
      ).toJson(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Stories'),
        // actions: [
        //   IconButton(
        //     onPressed: insertStory,
        //     icon: const Icon(Icons.add),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: ref.watch(storyProvider).when(
              error: (error, stackTrace) => const Center(
                child: Text('Error'),
              ),
              loading: () => const _LoadingGrid(),
              data: (stories) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: stories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final story = stories[index];
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: CacheImage(
                            image: story.isImage ? story.url : story.thumbnail,
                            onTap: (_) {
                              openStory(context, stories, index);
                            },
                          ),
                        ),
                        if (story.isVideo) _title(story.duration),
                      ],
                    );
                  },
                );
              },
            ),
      ),
    );
  }

  Widget _title(int duration) {
    return Positioned(
      right: 5.0,
      bottom: 5.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.black38,
        ),
        padding: const EdgeInsets.all(3.0),
        child: Text(
          AppUtils.formatDuration(Duration(seconds: duration)),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
        ),
      ),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: 18,
      itemBuilder: (BuildContext context, int index) {
        return const ItemLoading();
      },
    );
  }
}
