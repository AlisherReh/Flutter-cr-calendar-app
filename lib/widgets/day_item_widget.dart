import 'package:cr_calendar/cr_calendar.dart';
import 'package:cr_calendar_example/res/colors.dart';
import 'package:flutter/material.dart';

/// Виджет ячейки дня для календаря
/// Это виджет Flutter, который отображает ячейку одного дня в календаре.
///
/// DayItemWidget принимает в качестве входных данных объект DayItemProperties, который содержит информацию об отображаемом дне.
/// Затем виджет использует эту информацию для определения внешнего вида ячейки.
///
/// Оператор if внизу условно отображает индикатор количества событий в зависимости от того,
/// есть ли какие-либо события, которые не поместились в ячейку.
class DayItemWidget extends StatelessWidget {
  const DayItemWidget({
    required this.properties,
    super.key,
  });

  final DayItemProperties properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF1C2833).withOpacity(1), width: 0.3)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 4),
            alignment: Alignment.topCenter,
            child: Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                color: properties.isCurrentDay ? violet : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('${properties.dayNumber}',
                    style: TextStyle(
                        color: properties.isCurrentDay
                            ? Colors.white
                            : Colors.white
                                .withOpacity(properties.isInMonth ? 1 : 0.5))),
              ),
            ),
          ),
          if (properties.notFittedEventsCount > 0)
            Container(
              padding: const EdgeInsets.only(right: 2, top: 2),
              alignment: Alignment.topRight,
              child: Text('+${properties.notFittedEventsCount}',
                  style: TextStyle(
                      fontSize: 10,
                      color:
                          Colors.white.withOpacity(properties.isInMonth ? 1 : 0.5))),
            ),
        ],
      ),
    );
  }
}
