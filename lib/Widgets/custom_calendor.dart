import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NormalCalendar extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final DateTime initialDate;

  const NormalCalendar({super.key, 
    required this.onDateSelected,
    required this.initialDate,
  });
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
      
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      onDateChanged: (date) {
        onDateSelected(date); // Pass the selected date back
      },
    );
  }
}






class CustomCalendar extends StatefulWidget {
  final void Function(DateTime startDate, DateTime endDate)? onWeekSelected;
  final DateTime initialWeekStartDate; // Add initialWeekStartDate
  final DateTime initialWeekEndDate;
  final void Function(DateTime selectedMonth)? onMonthSelected;

  const CustomCalendar({
    super.key,
    this.onWeekSelected,
    required this.initialWeekStartDate,
    required this.onMonthSelected, // Initialize in the constructor
    required this.initialWeekEndDate,
  });
  @override
  // ignore: library_private_types_in_public_api
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  List<List<DateTime>> _weeks = [];
  int _selectedWeekIndex = -1;
  DateTime? _selectedMonth;

  @override
  void initState() {
    super.initState();
    _setWeeksForMonth(_focusedDay);
    //_selectInitialWeek();
  }

  void _setWeeksForMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    DateTime currentWeekStart =
        firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday - 1));
    DateTime currentWeekEnd = currentWeekStart.add( const Duration(days: 6));

    _weeks = [];

    while (currentWeekStart.isBefore(lastDayOfMonth)) {
      _weeks.add(List<DateTime>.generate(7, (index) {
        return currentWeekStart.add(Duration(days: index));
      }));

      currentWeekStart = currentWeekEnd.add(const Duration(days: 1));
      currentWeekEnd = currentWeekStart.add( const Duration(days: 6));
    }

    setState(() {});
  }

//Week  start to end date func
  void _selectWeek(int index) {
    setState(() {
      _selectedWeekIndex = index;
      final selectedWeek = _weeks[index];
      final startDate = selectedWeek.first;
      final endDate = selectedWeek.last;

      if (widget.onWeekSelected != null) {
        widget.onWeekSelected!(startDate, endDate);
      }
    });
  }

  void _changeMonth(int delta) {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + delta, 1);
      _setWeeksForMonth(_focusedDay);
    });
  }

  void _selectMonthWithYear(DateTime date) {
    setState(() {
      _selectedMonth = DateTime(date.year, date.month, 1);
      // Trigger the callback for when the month is selected
      if (widget.onMonthSelected != null) {
        widget.onMonthSelected!(_selectedMonth!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  DateFormat('MMMM yyyy').format(_focusedDay),
                  style:const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // Ensure buttons only take up as much space as needed
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _changeMonth(-1);
                      },
                      style: ElevatedButton.styleFrom(
                        shape:const CircleBorder(),
                        backgroundColor: Colors.white,
                        elevation: 4,
                        minimumSize:const Size(30, 30),
                      ),
                      child:const Icon(Icons.arrow_back_ios,
                          color: Colors.blueAccent, size: 16),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _changeMonth(1);
                      },
                      style: ElevatedButton.styleFrom(
                        shape:const CircleBorder(),
                        backgroundColor:const Color(0xFFE1EDFF),
                        elevation: 4,
                        minimumSize:const Size(30, 30),
                      ),
                      child:const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueAccent,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
             const SizedBox(width: 12),
            ],
          ),
        ),
       const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Select Week',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
       
        SizedBox(
          height: 170,
          child: ListView.builder(
            itemCount: _weeks.length,
            itemBuilder: (context, index) {
              List<DateTime> week = _weeks[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 24,
                      child: Radio(
                        value: index,
                        activeColor: const Color.fromARGB(255, 249, 131, 34),
                        groupValue: _selectedWeekIndex,
                        onChanged: (int? value) {
                          if (value != null) {
                            _selectWeek(value);
                          }
                        },
                      ),
                    ),
                  const  SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${DateFormat('d MMM').format(week.first)} - ${DateFormat('d MMM').format(week.last)}',
                    ),
                  ],
                ),
              );
             
            },
          ),
        ),
       
       const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'Select Month',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding:const EdgeInsets.all(8.0),
          height: 70, // Height of the container
          width: double.infinity, // Full width of the container
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            itemCount: 12, // Number of months
            // itemBuilder: (context, index) {
            //   // final date = DateTime(2024, index + 1);
            //   final currentYear = DateTime.now().year;
            //   final date = DateTime(currentYear, index + 1);

            //   final month = DateFormat('MMM').format(date);
            //   final year = DateFormat('yyyy').format(date);

            //   return GestureDetector(   
            //     onTap: () {
            //       setState(() {
            //         _selectMonthWithYear(DateTime(
            //             date.year, date.month, 1)); // Update selected month
            //       });
            //     },
            //     child: Align(
            //       alignment: Alignment.center,
            //       child: AnimatedContainer(
            //         duration:const Duration(milliseconds: 300),
            //         margin:const EdgeInsets.symmetric(horizontal: 8.0),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //               color: _selectedMonth?.month == index + 1
            //                   ? Colors.orange
            //                   : Colors.grey),
            //           borderRadius: BorderRadius.circular(8.0),
            //           color: _selectedMonth?.month == index + 1
            //               ? Colors.orange
            //               : Colors.white,
            //         ),
            //         child: SizedBox(
            //           width: 65, // Fixed width for each month item
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: [
            //               Text(month,
            //                   style: TextStyle(
            //                       color: _selectedMonth?.month == index + 1
            //                           ? Colors.white
            //                           : Colors.grey)),
            //               Text(year,
            //                   style: TextStyle(
            //                       color: _selectedMonth?.month == index + 1
            //                           ? Colors.white
            //                           : Colors.grey)),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   );
            // },
            itemBuilder: (context, index) {
  final now = DateTime.now();
  final date = DateTime(now.year, index + 1); // FIXED: now.year instead of 2024
  final month = DateFormat('MMM').format(date);
  final year = DateFormat('yyyy').format(date);

  return GestureDetector(
    onTap: () {
      setState(() {
        _selectMonthWithYear(DateTime(date.year, date.month, 1));
      });
    },
    child: Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: _selectedMonth?.month == index + 1
                  ? Color(0xFF623089)
                  : Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
          color: _selectedMonth?.month == index + 1
              ? Color(0xFF623089)
              : Colors.white,
        ),
        child: SizedBox(
          width: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                month,
                style: TextStyle(
                    color: _selectedMonth?.month == index + 1
                        ? Colors.white
                        : Colors.grey),
              ),
              Text(
                year,
                style: TextStyle(
                    color: _selectedMonth?.month == index + 1
                        ? Colors.white
                        : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    ),
  );
},

          ),
        ),
      ],
    );
  }
}
