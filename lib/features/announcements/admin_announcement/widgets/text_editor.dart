import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:jesusvlsco/core/utils/constants/colors.dart';
import 'package:jesusvlsco/core/utils/constants/sizer.dart';

class TextEditor extends StatelessWidget {
  const TextEditor({
    super.key,
    required QuillController controller,
  }) : _controller = controller;

  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizer.wp(360), // Add width constraint to main container
      decoration: BoxDecoration(
        color: AppColors.quill,
        borderRadius: BorderRadius.circular(Sizer.wp(10)),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          // Toolbar section - Remove Row wrapper and add Expanded
          Expanded(
            flex: 0, // Don't take extra space
            child: QuillSimpleToolbar(
              controller: _controller,
              config: QuillSimpleToolbarConfig(
                toolbarRunSpacing: 20,
                toolbarIconCrossAlignment: WrapCrossAlignment.start,
                toolbarSize: Sizer.wp(24),
                showLeftAlignment: true,
                showDividers: false,
                // Show only these items
                showBoldButton: true,
                showItalicButton: true,
                showUnderLineButton: true,
                showListNumbers: true,
                showListBullets: true,
                showLink: true,
                // Hide all other items
                showClearFormat: false,
                showHeaderStyle: false,
                showFontFamily: false,
                showFontSize: false,
                showStrikeThrough: false,
                showInlineCode: false,
                showColorButton: false,
                showBackgroundColorButton: false,
                showListCheck: false,
                showCodeBlock: false,
                showQuote: false,
                showIndent: false,
                showUndo: false,
                showRedo: false,
                showDirection: false,
                showSearchButton: false,
                showSubscript: false,
                showSuperscript: false,
                showAlignmentButtons: false,
              ),
            ),
          ),
       
          Container(
            width: double.infinity, // Use full width of parent
            height: Sizer.hp(164),
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: QuillEditor(
                controller: _controller,
                focusNode: FocusNode(),
                scrollController: ScrollController(),
                config: QuillEditorConfig(
    scrollable: true,
    enableSelectionToolbar: true,
    placeholder: 'description here....',
    
    customStyles: DefaultStyles(
      sizeSmall: TextStyle(
        
      )
    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
