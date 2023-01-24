import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main(List<String> args) {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this ?? other;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

// void testIt() {
//   final int? int1 = null;
//   final int? int2 = null;
//   final result = int1 + int2;
//   print(result);
// }

class Counter extends StateNotifier<int?> {
  Counter() : super(null);

  void increment() => state = state == null ? 1 : state + 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(counterProvider);
            final text = count == null ? 'Press the button' : count.toString();
            return Center(child: Text(text));
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                // onPressed: () {
                //   ref.read(counterProvider.notifier).increment();
                // },
                onPressed: ref.read(counterProvider.notifier).increment,
                child: const Text('Increment count'),
              );
            },
          ),
        ],
      ),
    );
  }
}
