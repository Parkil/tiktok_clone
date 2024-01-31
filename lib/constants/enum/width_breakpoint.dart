enum WidthBreakPoint {
  sm(minWidth: 0.0, maxWidth: 640.0, columnCount: 2),
  md(minWidth: 640.1, maxWidth: 768.0, columnCount: 3),
  lg(minWidth: 768.1, maxWidth: 1024.0, columnCount: 4),
  xl(minWidth: 1024.1, maxWidth: 1280.0, columnCount: 5),
  xxl(minWidth: 1280.1, maxWidth: 1536.0, columnCount: 5);

  const WidthBreakPoint({
    required this.minWidth,
    required this.maxWidth,
    required this.columnCount,
  });

  final double minWidth;
  final double maxWidth;
  final int columnCount;

  static findByWidth(double width) {
    return  WidthBreakPoint.values.lastWhere(
      (element) => width >= element.minWidth && width <= element.maxWidth,
      orElse: () {
        if (width > xxl.maxWidth) {
          return WidthBreakPoint.xxl;
        } else {
          return WidthBreakPoint.sm;
        }
      },
    );
  }
}
