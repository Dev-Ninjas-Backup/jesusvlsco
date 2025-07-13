import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DevEditor extends StatelessWidget {
  // The key is not necessary for this usage of Quill
  final QuillController _controller = QuillController.basic();

  DevEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dev Editor"),
      ),
      body: SafeArea(
        child: Column(
          children: [
  QuillSimpleToolbar(
  controller: _controller,
  config: const QuillSimpleToolbarConfig(),
),
QuillEditor(
  controller: _controller,

  focusNode: FocusNode(),
  scrollController: ScrollController(),


)
 
 
 
 
 
 


      
          ],
        ),
      ),
    );
  }
}
