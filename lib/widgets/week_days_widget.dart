import 'package:cr_calendar/cr_calendar.dart';
import 'package:cr_calendar_example/res/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Виджет, представляющий дни недели в строке над представлением календарного месяца.
///
/// Виджет возвращает контейнер высотой 40 и центрированный текстовый виджет внутри него.
/// Виджет «Текст» отображает первую букву названия дня в верхнем регистре (например, «М» для понедельника)
/// и окрашен в фиолетовый цвет, непрозрачный на 90 %.
class WeekDaysWidget extends StatelessWidget {
  const WeekDaysWidget({
    required this.day,
    super.key,
  });

  /// Значение [WeekDay] из [WeekDaysBuilder].
  final WeekDay day;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Center(
        child: Text(
          describeEnum(day).substring(0, 1).toUpperCase(),
          style: TextStyle(
            color: violet.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
