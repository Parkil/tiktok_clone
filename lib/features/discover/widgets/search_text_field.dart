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
class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _searchTextController = TextEditingController();
  late bool _currentTextNotEmpty;

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
    /*
      TextField Decorator -> Row 로 변경한 이유
      Decorator 의 prefixIcon, suffixIcon 의 경우 최소 크기가 48 * 48 px 이기 때문에
      다음 문제가 발생 한다

      1.isDense 효과가 작동 하지 않는다
      2.prefixIcon 과 실제 입력 하는 커서 와의 간격을 줄일수 있는 방법이 없다 ( left padding 을 줘서 눈속임 을 할수 는 있다 )
     */
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(Sizes.size12)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: Sizes.size16,
              color: Colors.grey.shade600,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _searchTextController,
              minLines: 1,
              maxLines: 1,
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
              onChanged: _onChanged,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true, // 추가 vertical padding 제거
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            child: GestureDetector(
              onTap: _clearSearchText,
              child: FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                size: _currentTextNotEmpty ? Sizes.size16 : 0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
