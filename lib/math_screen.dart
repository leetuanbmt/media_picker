import 'dart:convert';

import 'package:gmo_media_picker/media_picker.dart';

import 'core/config.dart';

class MathScreen extends StatefulWidget {
  const MathScreen({super.key});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen> {
  final permutations = ValueNotifier<List>([]);
  List get permutationsValue => permutations.value;
  final List _items = [];
  @override
  void initState() {
    List<int> elements = [1, 2, 3];
    generatePermutations(elements);
    super.initState();
  }

// generate all permutations of a list
  void generatePermutations(List<int> elements) {
    List<int> current = List<int>.from(elements);
    int n = current.length;
    _items.add(jsonDecode(jsonEncode(current)));
    permutations.value = _items;

    while (true) {
      int i = n - 2;
      while (i >= 0 && current[i] >= current[i + 1]) {
        i--;
      }

      if (i < 0) {
        break;
      }

      int j = n - 1;
      while (current[j] <= current[i]) {
        j--;
      }

      swap(current, i, j);
      reverse(current, i + 1);
      _items.add(jsonDecode(jsonEncode(current)));
      permutations.value = _items;
    }
  }

// swap the position of two elements
  void swap(List<int> elements, int i, int j) {
    int temp = elements[i];
    elements[i] = elements[j];
    elements[j] = temp;
  }

// reverse the elements from index 'start' to the end
  void reverse(List<int> elements, int start) {
    int i = start;
    int j = elements.length - 1;

    while (i < j) {
      swap(elements, i, j);
      i++;
      j--;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Screen'),
        actions: [
          IconButton(
            onPressed: () {
              AssetPicker.pickAssets(context);
            },
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      body: Center(
        child: ValueListenableBuilder<List>(
          valueListenable: permutations,
          builder: (context, value, child) {
            Logger.log(value);
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(value[index].toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
