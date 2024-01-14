import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SearchTextField extends StatefulWidget {
  final Function? onSubmitted;
  final Function? onChanged;

  const SearchTextField({super.key, this.onSubmitted, this.onChanged});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

/*
  prefix, prefixIcon 의 차이
  prefix - TextField 가 focusing 되었을 때에만 표시 된다
  prefixIcon - 항상 표시 된다
 */

/*
  유의점
  TextField Decorator 의 prefixIcon, suffixIcon 은 최소 size 가 48 * 48 px
  이기 때문에 만약 TextField 의 height 를 가늘게 만들고 싶으면 TextField 가
  아닌 다른 방식을 사용 해야 한다
 */
class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _searchTextController = TextEditingController();
  late bool _currentTextNotEmpty;

  InputDecoration _textFieldDecoration() {
    return InputDecoration(
      hintText: "Search",
      isDense: true,
      // input field 기본 padding 제거
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Sizes.size12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Sizes.size8,
        vertical: Sizes.size6,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(
          left: Sizes.size10,
        ),
        child: Row(
          // row widget 자체가 vertical center 에 정렬 하는 효과가 있음
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey.shade900,
            ),
          ],
        ),
      ),
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_currentTextNotEmpty)
            GestureDetector(
              onTap: _clearSearchText,
              child: FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                color: Colors.grey.shade800,
                size: Sizes.size16,
              ),
            ),
        ],
      ),
    );
  }

  void _clearSearchText() {
    _searchTextController.clear();
  }

  @override
  void initState() {
    super.initState();
    _currentTextNotEmpty = false;
    _searchTextController.addListener(() {
      setState(() {
        _currentTextNotEmpty = _searchTextController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
  }

  void onSubmitted(String text) {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextField(
              controller: _searchTextController,
              minLines: 1,
              maxLines: 1,
              textInputAction: TextInputAction.search,
              decoration: _textFieldDecoration(),
              onSubmitted: onSubmitted,
              onChanged: _onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
