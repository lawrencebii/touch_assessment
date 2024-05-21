import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_assessment/features/Home/home_provider.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final String id;

  ExpandableText({
    required this.text,
    required this.id,
  });

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(
          text: widget.text,
          style: TextStyle(
            color: Theme.of(context).hintColor.withOpacity(0.5),
            fontSize: 11,
          ),
        );

        final tp = TextPainter(
          text: span,
          maxLines: _isExpanded ? null : 1,
          textDirection: TextDirection.ltr,
        );
        tp.ellipsis = '...';

        tp.layout(maxWidth: constraints.maxWidth);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (tp.didExceedMaxLines != _isOverflowing) {
            setState(() {
              _isOverflowing = tp.didExceedMaxLines;
            });
          }
        });

        return Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  maxLines: widget.id == provider.maxedID.toString() ? null : 1,
                  overflow: widget.id == provider.maxedID.toString()
                      ? null
                      : TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).hintColor.withOpacity(0.5),
                    fontSize: 11,
                  ),
                ),
                if (_isOverflowing)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });

                      context.read<HomeProvider>().setMaxedId(widget.id);
                    },
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                          color: Theme.of(context).primaryColor,
                        )),
                      ),
                      child: Text(
                        widget.id == provider.maxedID.toString()
                            ? "view less"
                            : "view more",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 11,
                            height: 0),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
