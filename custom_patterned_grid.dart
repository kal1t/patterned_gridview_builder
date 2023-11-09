import 'package:flutter/material.dart';

class CustomPatternedGrid extends StatelessWidget {
  const CustomPatternedGrid({
    required this.inputFlexPattern,
    required this.itemBuilder,
    required this.itemCount,
    super.key,
    this.shrinkWrap = false,
    this.padding,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 4,
    this.physics,
    this.childHeight,
    this.controller,
  });

  final List<List<int>> inputFlexPattern;
  final int? childHeight;
  final int crossAxisSpacing;
  final int mainAxisSpacing;
  final bool shrinkWrap;
  final int itemCount;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Widget Function(BuildContext context, int index, int flexPattern)
      itemBuilder;

  @override
  Widget build(BuildContext context) {
    // Если количество создаваемых элементов (itemCount) больше
    // заданного длинны паттерна, то
    // повторяем паттерн, чтобы его длинна была больше элементов
    List<List<int>> setFinalPattern() {
      var totalFlexes = 0;

      /// высчитываем общее количесвто flex
      for (final sublist in inputFlexPattern) {
        totalFlexes += sublist.length;
      }

      if (itemCount > totalFlexes) {
        final finalPattern = <List<int>>[];

        final times = (itemCount / totalFlexes).ceil();

        for (var i = 0; i < times; i++) {
          finalPattern.addAll(inputFlexPattern);
        }

        return finalPattern;
      } else {
        return inputFlexPattern;
      }
    }

    final finalPattern = setFinalPattern();
    final totalWidgetsWithFlexes = <List<Map<Widget, int>>>[];
    var itemIndex = 0; // индекс элемента

    return ListView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding,
      controller: controller,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: (_, index) {
        // Тут мы соединяем widgets к flex в Map
        for (var i = 0; i < finalPattern.length; i++) {
          final currentPatternElements = <Map<Widget, int>>[];
          final difference = itemCount - itemIndex;
          for (var j = 0; j < finalPattern[i].length; j++) {
            final currentFlex = finalPattern[i][j];

            late Map<Widget, int> widgetWithFlex; // map виджета с его flex

            if (itemIndex < itemCount) {
              // виджет с его flex

              late Widget widget;

              // если разница меджу итерируемым элементом и остатком меньше длинны паттерна,
              // то я задаю ему другой flex.
              // Чтобы отображение картинок было корректным
              if (difference < finalPattern[i].length) {
                if (difference <= 2) {
                  widget = itemBuilder(context, itemIndex, 3);
                  widgetWithFlex = {widget: 3};
                }
              } else {
                widget = itemBuilder(context, itemIndex, currentFlex);
                widgetWithFlex = {widget: currentFlex};
              }

              itemIndex++;
            } else {
              break;
            }

            currentPatternElements.add(widgetWithFlex);
          }

          totalWidgetsWithFlexes.add(currentPatternElements);
        }

        final childrenInRow = <Widget>[];

        /// Добавляю к виджетам Expanded с его значением flex
        for (final widgetWithFlex in totalWidgetsWithFlexes[index]) {
          childrenInRow.add(
            Expanded(
              flex: widgetWithFlex.values.first,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: crossAxisSpacing.toDouble(),
                  vertical: mainAxisSpacing.toDouble(),
                ),
                height: childHeight?.toDouble(),
                child: widgetWithFlex.keys.first,
              ),
            ),
          );
        }

        return Row(children: childrenInRow);
      },
    );
  }
}
