import 'package:cr_calendar/cr_calendar.dart';
import 'package:cr_calendar_example/res/colors.dart';
import 'package:cr_calendar_example/utills/constants.dart';
import 'package:cr_calendar_example/utills/extensions.dart';
import 'package:cr_calendar_example/widgets/create_event_dialog.dart';
import 'package:cr_calendar_example/widgets/day_events_bottom_sheet.dart';
import 'package:cr_calendar_example/widgets/day_item_widget.dart';
import 'package:cr_calendar_example/widgets/event_widget.dart';
import 'package:cr_calendar_example/widgets/week_days_widget.dart';
import 'package:flutter/material.dart';

/// Класс CalendarPage представляет главную страницу приложения, на которой расположен календарь и управляющие элементы.
///
/// Календарь реализован с использованием библиотеки cr_calendar. Он отображает дни месяца, разделяет их по неделям и позволяет пользователю просматривать события, связанные с конкретными днями.
///
/// Класс _CalendarPageState содержит логику управления календарем и обработки событий пользователя. В методе initState происходит инициализация календаря и добавление примеров событий. В методе dispose происходит очистка ресурсов, занятых календарем.
///
/// Основные методы класса _CalendarPageState включают:
///
/// _changeCalendarPage - переход на следующий или предыдущий месяц календаря
/// _onCalendarPageChanged - обработка смены месяца календаря
/// _setTexts - установка текста заголовка на основе выбранного месяца и года
/// _showCurrentMonth - переход к текущему месяцу
/// _addEvent - открытие диалогового окна для создания нового события
/// _createExampleEvents - добавление примеров событий в календарь
/// _showDayEventsInModalSheet - отображение модального окна с событиями конкретного дня календаря.
/// Кроме того, класс _CalendarPageState определяет виджеты, используемые для отображения элементов календаря, такие как DayItemWidget, WeekDaysWidget и EventWidget.
///
/// В целом, этот код позволяет создавать календарное приложение с использованием Flutter и библиотеки cr_calendar.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _currentDate = DateTime.now();

  late CrCalendarController _calendarController;
  late String _appbarTitle;
  late String _monthName;

  @override
  void initState() {
    _setTexts(_currentDate.year, _currentDate.month);
    _createExampleEvents();

    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: Text(_appbarTitle),
        actions: [
          IconButton(
            tooltip: 'Delete all events',
            icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _calendarController.removeAllEvents();
                });
              }
          ),
          IconButton(
            tooltip: 'Go to current date',
            icon: const Icon(Icons.calendar_today),
            onPressed: _showCurrentMonth,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          /// Строка управления календарем.
          Container(
            color: Color(0xFF212F3D),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    _changeCalendarPage(showNext: false);
                  },
                ),
                Text(
                  _monthName,
                  style: const TextStyle(
                      fontSize: 16, color: violet, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    _changeCalendarPage(showNext: true);
                  },
                ),
              ],
            ),
          ),

          /// Просмотр календаря.
          Expanded(
            child: CrCalendar(
              backgroundColor: Color(0xFF212F3D),
              firstDayOfWeek: WeekDay.monday,
              eventsTopPadding: 32,
              initialDate: _currentDate,
              maxEventLines: 3,
              controller: _calendarController,
              forceSixWeek: true,
              dayItemBuilder: (builderArgument) =>
                  DayItemWidget(properties: builderArgument),
              weekDaysBuilder: (day) => WeekDaysWidget(day: day),
              eventBuilder: (drawer) => EventWidget(drawer: drawer),
              onDayClicked: _showDayEventsInModalSheet,
              minDate: DateTime.now().subtract(const Duration(days: 1000)),
              maxDate: DateTime.now().add(const Duration(days: 180)),
            ),
          ),
        ],
      ),
    );
  }

  /// Управление календарем с помощью кнопок со стрелками.
  void _changeCalendarPage({required bool showNext}) => showNext
      ? _calendarController.swipeToNextMonth()
      : _calendarController.swipeToPreviousPage();

  void _onCalendarPageChanged(int year, int month) {
    setState(() {
      _setTexts(year, month);
    });
  }

  /// Установка текста панели приложения и название месяца поверх календаря.
  void _setTexts(int year, int month) {
    final date = DateTime(year, month);
    _appbarTitle = date.format(kAppBarDateFormat);
    _monthName = date.format(kMonthFormat);
  }

  /// Показать страницу текущего месяца.
  void _showCurrentMonth() {
    _calendarController.goToDate(_currentDate);
  }

  /// Показать [CreateEventDialog] с настройками для нового события.
  Future<void> _addEvent() async {
    final event = await showDialog(
        context: context, builder: (context) => const CreateEventDialog());
    if (event != null) {
      _calendarController.addEvent(event);
    }
  }

  void _createExampleEvents() {
    final now = _currentDate;
    _calendarController = CrCalendarController(
      onSwipe: _onCalendarPageChanged,
      events: [

      ],
    );
  }


  void _showDayEventsInModalSheet(
      List<CalendarEventModel> events, DateTime day) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
        isScrollControlled: true,
        context: context,
        builder: (context) => DayEventsBottomSheet(
              events: events,
              day: day,
              screenHeight: MediaQuery.of(context).size.height,
            ));
  }
}
