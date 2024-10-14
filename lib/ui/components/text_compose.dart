import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextCompose extends StatefulWidget {
  TextCompose(this.sendMessage);

  final Function({String text, XFile imgFile}) sendMessage;

  @override
  State<TextCompose> createState() => _TextComposeState();
}

class _TextComposeState extends State<TextCompose> {
  final TextEditingController _textMessageController = TextEditingController();
  bool _isComposing = false;

  void _reset() {
    _textMessageController.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              final XFile? imgFile = await ImagePicker().pickImage(source: ImageSource.camera);
              if(imgFile == null) return;
              widget.sendMessage(imgFile: imgFile);

            },
            icon: Icon(Icons.photo_camera),
          ),
          Expanded(
            child: TextField(
              controller: _textMessageController,
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text) {
                widget.sendMessage(text: text);
                _reset();
              },
              decoration:
                  InputDecoration.collapsed(hintText: 'Enviar uma mensagem...'),
            ),
          ),
          IconButton(
            onPressed: _isComposing
                ? () {
                    widget.sendMessage(text: _textMessageController.text);
                    _reset();
                  }
                : null,
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
