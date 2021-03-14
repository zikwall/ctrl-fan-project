import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final Function onSearch;
  final Function onCancel;
  final bool withBackward;

  const SearchWidget({
    Key key,
    @required this.onSearch,
    @required this.onCancel,
    this.withBackward,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: _controller,
          autocorrect: true,
          onChanged: (text) {
            widget.onSearch(text);
          },
          style: TextStyle(color: Color(0xfff7892b)),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              bottom: 35 / 2,
            ),
            hintText: 'Поиск',
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xfff7892b),
              size: 20,
            ),
            hintStyle: TextStyle(color: Color(0xfff7892b)),
            filled: true,
            fillColor: Color(0xff161b22),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Color(0xff0d1117), width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Color(0xff0d1117), width: 0.5),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                widget.onCancel();
                _controller.clear();
                FocusScope.of(context).unfocus();
              },
              icon: Icon(
                Icons.clear,
                color: Color(0xfff7892b),
                size: 20,
              ),
            ),
          )
      ),
    );
  }
}