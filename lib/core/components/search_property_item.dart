import 'package:flutter/material.dart';
import 'package:madar_app/core/utils/functions/responsive.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_strings.dart';

/// Property search field with dropdown suggestions
class PropertySearchField extends StatefulWidget {
  const PropertySearchField({
    super.key,
    required this.controller,
    required this.suggestions,
    this.onSearch,
    this.onSelectProperty,
    required this.colors,
  });

  final TextEditingController controller;
  final List<String> suggestions;
  final Function(String)? onSearch;
  final Function(String)? onSelectProperty;
  final AppThemeColors colors;

  @override
  State<PropertySearchField> createState() => _PropertySearchFieldState();
}

class _PropertySearchFieldState extends State<PropertySearchField> {
  bool _showSuggestions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText:AppStrings.searchProperty,
            filled: true,
            fillColor: widget.colors.textFieldFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: widget.colors.borderColor),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.width,
              vertical: 12.height,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _showSuggestions = value.isNotEmpty;
            });
            widget.onSearch?.call(value);
          },
          onTap: () {
            if (widget.controller.text.isNotEmpty) {
              setState(() => _showSuggestions = true);
            }
          },
        ),
        if (_showSuggestions && widget.suggestions.isNotEmpty)
          SizedBox(height: 8.height),
        if (_showSuggestions && widget.suggestions.isNotEmpty)
          Container(
            constraints: BoxConstraints(maxHeight: 200.height),
            decoration: BoxDecoration(
              color: widget.colors.cardBackground,
              border: Border.all(color: widget.colors.borderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.suggestions[index]),
                  onTap: () {
                    widget.controller.text = widget.suggestions[index];
                    widget.onSelectProperty?.call(widget.suggestions[index]);
                    setState(() => _showSuggestions = false);
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
