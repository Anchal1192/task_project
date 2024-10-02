import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/bloc.dart';
import 'Bloc/event_bloc.dart';
import 'Presentation/HomeScreen.dart';
import 'Repository/ApiService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter BLoC Example',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PostBloc(repository: PostRepository())..add(FetchPosts()),
        child: DynamicTextFields(),
      ),
    );
  }
}
class DynamicTextFields extends StatefulWidget {
  @override
  _DynamicTextFieldsState createState() => _DynamicTextFieldsState();
}

class _DynamicTextFieldsState extends State<DynamicTextFields> {

  final List<TextEditingController> _controllers = [TextEditingController()];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeTextField(int index) {
    setState(() {
      _controllers[index].dispose();
      _controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Adding TextField',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Expanded TextField
                      Expanded(
                        child: TextField(
                          controller: _controllers[index],
                          decoration: InputDecoration(
                            labelText: 'Enter text ${index + 1}',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          if (_controllers.length > 1) {
                            _removeTextField(index);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap: _addTextField,
            child: Container(
              margin: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              color: Colors.purple,
              alignment: Alignment.center,
              height: 40,
              child: const Text('Add TextField',style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}


