import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String _selectedPeriod = 'week';
  DateTime? _selectedMonth; // week, month, allTime
  final List<Map<String, dynamic>> _habits = [
    {
      'id': 1,
      'title': 'Drink Water',
      'description': 'Drink 8 glasses of water daily',
      'target': 8,
      'current': 6,
      'streak': 12,
      'color': const Color(0xFF3B82F6),
      'icon': Icons.water_drop,
      'unit': 'glasses',
      'frequency': 'daily',
      'isDaily': true,
      'dailyCompletion': [0.8, 0.9, 1.0, 0.7, 0.85, 0.95, 0.75], // Last 7 days
    },
    {
      'id': 2,
      'title': 'Read Books',
      'description': 'Read for 30 minutes daily',
      'target': 30,
      'current': 25,
      'streak': 8,
      'color': const Color(0xFF10B981),
      'icon': Icons.menu_book,
      'unit': 'minutes',
      'frequency': 'daily',
      'isDaily': true,
      'dailyCompletion': [0.7, 0.8, 0.9, 1.0, 0.6, 0.85, 0.83], // Last 7 days
    },
    {
      'id': 3,
      'title': 'Exercise',
      'description': 'Workout for 45 minutes',
      'target': 45,
      'current': 45,
      'streak': 5,
      'color': const Color(0xFFF59E0B),
      'icon': Icons.fitness_center,
      'unit': 'minutes',
      'frequency': 'daily',
      'isDaily': true,
      'dailyCompletion': [1.0, 0.7, 0.9, 1.0, 0.8, 0.95, 1.0], // Last 7 days
    },
    {
      'id': 4,
      'title': 'Meditation',
      'description': 'Meditate for 15 minutes',
      'target': 15,
      'current': 10,
      'streak': 3,
      'color': const Color(0xFF8B5CF6),
      'icon': Icons.self_improvement,
      'unit': 'minutes',
      'frequency': 'daily',
      'isDaily': true,
      'dailyCompletion': [0.6, 0.5, 0.7, 0.8, 0.4, 0.65, 0.67], // Last 7 days
    },
    {
      'id': 5,
      'title': 'Sleep Early',
      'description': 'Sleep before 11 PM',
      'target': 1,
      'current': 1,
      'streak': 7,
      'color': const Color(0xFF06B6D4),
      'icon': Icons.bedtime,
      'unit': 'time',
      'frequency': 'daily',
      'isDaily': true,
      'dailyCompletion': [1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0], // Last 7 days
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildStatisticsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final completedToday = _habits
        .where((habit) => habit['current'] >= habit['target'])
        .length;
    final totalHabits = _habits.length;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedToday of $totalHabits tasks completed today',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [_buildGraphSection()],
    );
  }

  Widget _buildGraphSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              _buildPeriodSelector(),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(height: 250, child: _buildProgressChart()),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPeriodButton('Week', 'week'),
          _buildPeriodButton('Month', 'month'),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String label, String period) {
    final isSelected = _selectedPeriod == period;
    return GestureDetector(
      onTap: () {
        if (period == 'month') {
          _showMonthPicker();
        } else {
          setState(() {
            _selectedPeriod = period;
            _selectedMonth = null;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressChart() {
    final data = _getChartData();

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey[200]!,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < data['labels'].length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      data['labels'][index],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: Colors.grey[300]!, width: 1),
            left: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: data['spots'],
            isCurved: false,
            color: const Color(0xFF6366F1),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: const Color(0xFF6366F1),
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        minY: 0,
        maxY: _habits.length.toDouble(),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => const Color(0xFF6366F1),
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((LineBarSpot touchedBarSpot) {
                return LineTooltipItem(
                  '${touchedBarSpot.y.toInt()} completed',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  void _showMonthPicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedMonth ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          _selectedPeriod = 'month';
          _selectedMonth = selectedDate;
        });
      }
    });
  }

  Map<String, dynamic> _getChartData() {
    List<FlSpot> spots = [];
    List<String> labels = [];

    int days = 7;

    switch (_selectedPeriod) {
      case 'week':
        days = 7;
        break;
      case 'month':
        days = 30;
        if (_selectedMonth != null) {
          days = DateTime(
            _selectedMonth!.year,
            _selectedMonth!.month + 1,
            0,
          ).day;
        }
        break;
    }

    for (int i = 0; i < days; i++) {
      int completedCount = 0;
      for (var habit in _habits) {
        if (habit['dailyCompletion'] != null) {
          final completions = habit['dailyCompletion'] as List<double>;
          final index = i % completions.length;
          // Count as completed if completion is >= 0.7 (70%)
          if (completions[index] >= 0.7) {
            completedCount++;
          }
        }
      }
      spots.add(FlSpot(i.toDouble(), completedCount.toDouble()));

      if (_selectedPeriod == 'week') {
        labels.add(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i % 7]);
      } else if (_selectedPeriod == 'month') {
        if (i % 5 == 0) {
          labels.add('${i + 1}');
        } else {
          labels.add('');
        }
      }
    }

    return {'spots': spots, 'labels': labels};
  }

  Widget _buildStatisticCard(Map<String, dynamic> habit) {
    final progress = habit['current'] / habit['target'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: habit['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(habit['icon'], color: habit['color'], size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      habit['description'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              _buildStreakBadge(habit['streak']),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${habit['current']}/${habit['target']} ${habit['unit']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          habit['color'],
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _buildActionButtons(habit),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakBadge(int streak) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department,
            color: Color(0xFFF59E0B),
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            '$streak',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF59E0B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> habit) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _incrementHabit(habit),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: habit['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.add, color: habit['color'], size: 20),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => _decrementHabit(habit),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.remove, color: Colors.grey[600], size: 20),
          ),
        ),
      ],
    );
  }

  void _incrementHabit(Map<String, dynamic> habit) {
    setState(() {
      if (habit['current'] < habit['target']) {
        habit['current']++;
        if (habit['current'] >= habit['target']) {
          habit['streak']++;
        }
      }
    });
  }

  void _decrementHabit(Map<String, dynamic> habit) {
    setState(() {
      if (habit['current'] > 0) {
        habit['current']--;
      }
    });
  }
}
