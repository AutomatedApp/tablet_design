

import 'package:flutter/cupertino.dart';
extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
extension mediaQueryExtension  on BuildContext{
  double get height=>MediaQuery.of(this).size.height;
  double get width=>MediaQuery.of(this).size.width;
  double get leftadding=>MediaQuery.of(this).padding.left;
  double get righttadding=>MediaQuery.of(this).padding.right;
  double get bottom=>MediaQuery.of(this).viewInsets.bottom;

}