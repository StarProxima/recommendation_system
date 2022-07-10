import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recommendation_system/data/app_styles.dart';
import 'package:recommendation_system/data/product_model.dart';
import 'package:recommendation_system/ui/pages/search_page.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({
    Key? key,
    required this.controller,
    required this.queryLoad,
    required this.focus,
    this.pushToSearchPage = false,
    this.backButton = false,
    this.onEditingComplete,
    this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final Future<List<Product>?> Function(String query) queryLoad;
  final FocusNode focus;
  final bool pushToSearchPage;
  final bool backButton;
  final String? hintText;
  final VoidCallback? onEditingComplete;
  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  @override
  void initState() {
    widget.focus.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  void pushToSearchPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SearchPage(
            queryLoad: widget.queryLoad,
            hintText: widget.hintText,
            controller: widget.controller,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: widget.controller,
        onTap: () {
          setState(() {});
        },
        onEditingComplete: () {
          setState(() {});
          if (widget.pushToSearchPage) pushToSearchPage();
          widget.onEditingComplete?.call();
        },
        textInputAction: TextInputAction.done,
        maxLines: 1,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.headlineText,
            ),
        textAlignVertical: TextAlignVertical.center,
        focusNode: widget.focus,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: widget.backButton
              ? EdgeInsets.zero
              : const EdgeInsets.only(left: 16),
          isDense: false,
          filled: true,
          fillColor: AppColors.divider,
          hintText: widget.hintText ?? 'Искать',
          hintStyle: Theme.of(context).textTheme.titleMedium,
          prefixIcon: widget.backButton
              ? IconButton(
                  onPressed: () {
                    widget.focus.unfocus();
                    widget.controller.clear();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                )
              : null,
          suffixIcon: widget.focus.hasFocus
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  onPressed: () {
                    widget.focus.unfocus();
                    if (widget.controller.text.isNotEmpty) {
                      widget.controller.clear();
                    }
                  },
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0, color: Color.fromRGBO(0, 0, 0, 0)),
          ),
        ),
      ),
    );
  }
}
