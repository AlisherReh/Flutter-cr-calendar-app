import 'package:cr_calendar/cr_calendar.dart';
import 'package:cr_calendar_example/res/colors.dart';
import 'package:flutter/material.dart';

/// Виджет ячейки дня для выбора диапазона.
///
/// Виджет PickerDayItemWidget принимает объект DayItemProperties,
/// который содержит информацию об отображаемом дне (например, номер дня, в текущем месяце или нет и т. д.).
///
/// Виджет PickerDayItemWidget отображает круглый номер дня в центре ячейки. Если день находится в пределах выбранного диапазона дат,
/// фон окрашивается в полупрозрачный фиолетовый цвет.
class PickerDayItemWidget extends StatelessWidget {
  const PickerDayItemWidget({
    required this.properties,
    super.key,
  });

  final DayItemProperties properties;

  @override
  Widget build(BuildContext context) {
    /// Блокировать соотношение сторон элементов, чтобы они были прямоугольниками.
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          /// Полупрозрачный фиолетовый фон для дней в выбранном диапазоне.
          if (properties.isInRange)

            /// Для первых и последних дней в диапазоне цвет фона виден только с одной стороны.
            Row(
              children: [
                Expanded(
                    child: Container(
                        color: properties.isFirstInRange
                            ? Colors.transparent
                            : violet.withOpacity(0.4))),
                Expanded(
                    child: Container(
                        color: properties.isLastInRange
                            ? Colors.transparent
                            : violet.withOpacity(0.4))),
              ],
            ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: properties.isFirstInRange ||
                      properties.isLastInRange ||
                      properties.isSelected
                  ? violet
                  : Colors.transparent,
            ),
            child: Center(
              child: Text('${properties.dayNumber}',
                  style: TextStyle(
                      color: properties.isInRange || properties.isSelected
                          ? Colors.white
                          : violet
                              .withOpacity(properties.isInMonth ? 1 : 0.5))),
            ),
          ),
        ],
      ),
    );
  }
}
