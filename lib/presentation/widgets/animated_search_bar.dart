import 'package:flutter/material.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';

class AnimatedSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final String hintText;
  final TextEditingController? controller;

  const AnimatedSearchBar({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.controller,
  });

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _textController = TextEditingController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (widget.controller == null) {
      _textController.dispose();
    }
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        _textController.clear();
        widget.onChanged('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 56,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search icon
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 56,
            height: 56,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _toggleExpand,
                child: Icon(
                  _isExpanded ? Icons.close : Icons.search,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),

          // Search field
          Expanded(
            child: SizeTransition(
              sizeFactor: _animation,
              axis: Axis.horizontal,
              child: TextField(
                controller: widget.controller ?? _textController,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
          ),

          // Clear button
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.horizontal,
            child: AnimatedOpacity(
              opacity: _isExpanded ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: SizedBox(
                width: 56,
                height: 56,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      _textController.clear();
                      widget.onChanged('');
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
