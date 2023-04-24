import 'package:cr_calendar_example/pages/calendar_page.dart';
import 'package:cr_calendar_example/res/colors.dart';
import 'package:flutter/material.dart';
///Он используется для настройки темы и стилей приложения, а также для запуска главной страницы приложения - CalendarPage.

/// При запуске приложения в методе main() вызывается функция runApp(), которая запускает виджет MyApp. Виджет MyApp является состоянием, поэтому его состояние управляется виджетом _MyAppState.

/// В методе build() виджета MyApp определяется тема приложения, включающая различные стили кнопок, диалоговых окон, плавающей кнопки, цвета и т.д.

/// Затем вызывается главная страница приложения CalendarPage(), которая является стейтфул-виджетом и отображает календарь событий.

/// Кроме того, в коде импортируются несколько библиотек (calendar_page.dart и colors.dart) для работы приложения.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /// Theme.
      theme: ThemeData(
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.black38),
        primaryColor: Colors.black38,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: violet),
        iconTheme: const IconThemeData(color: violet),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            foregroundColor: violet,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            shadowColor: Colors.transparent,
            elevation: 0,
            foregroundColor: violet,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF212F3D)
        ),
      ),

      home: const CalendarPage(),
    );
  }
}
