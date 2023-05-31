import 'package:bloc_sample/practice/bloc/counter_bloc.dart';
import 'package:bloc_sample/practice/bloc/counter_event.dart';
import 'package:bloc_sample/practice/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: const _CounterBody(),
    );
  }
}

class _CounterBody extends StatelessWidget {
  const _CounterBody();

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                final count = state.count;
                return Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterBloc.add(Increment()),
        tooltip: 'Increment',
        heroTag: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
