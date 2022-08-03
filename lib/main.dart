import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Counter",
        theme: ThemeData.dark(),
        home: BlocProvider(
            create: (context) => CounterCubit(), child: const HomePage()));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  late CounterCubit cubit;

  @override
  void didChangeDependencies() {
// TODO: implement didChangeDependencies
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Counter")),
      ),
      body: BlocConsumer<CounterCubit, int>(
        bloc: cubit,
        listener: (context, state) {
          const snackbar = SnackBar(content: Text("State is reached"));

          if (state == 5) {
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }
        },
        builder: (context, state) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  "$state",
                  style: TextStyle(fontSize: 30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cubit.increment();
                      },
                      child: const Text("Increment"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        cubit.reset();
                      },
                      child: const Text("Reset"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.all(25)),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        cubit.decrement();
                      },
                      child: const Text("Decrement"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.all(30)),
                    )
                  ],
                ),
              ]));
        },
      ),
    );
  }
}
