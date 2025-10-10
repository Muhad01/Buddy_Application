import 'package:flutter/material.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

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
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHabitsList(),
                  _buildStreaksView(),
                  _buildStatisticsView(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        backgroundColor: const Color(0xFF6366F1),
        child: const Icon(Icons.add, color: Colors.white),
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
            'My Habits',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedToday of $totalHabits habits completed today',
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

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6366F1),
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        tabs: const [
          Tab(text: 'Habits'),
          Tab(text: 'Streaks'),
          Tab(text: 'Stats'),
        ],
      ),
    );
  }

  Widget _buildHabitsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _habits.length,
      itemBuilder: (context, index) {
        final habit = _habits[index];
        return _buildHabitCard(habit);
      },
    );
  }

  Widget _buildHabitCard(Map<String, dynamic> habit) {
    final progress = habit['current'] / habit['target'];
    final isCompleted = habit['current'] >= habit['target'];

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

  Widget _buildStreaksView() {
    final sortedHabits = List<Map<String, dynamic>>.from(_habits);
    sortedHabits.sort((a, b) => b['streak'].compareTo(a['streak']));

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: sortedHabits.length,
      itemBuilder: (context, index) {
        final habit = sortedHabits[index];
        return _buildStreakCard(habit);
      },
    );
  }

  Widget _buildStreakCard(Map<String, dynamic> habit) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: habit['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(habit['icon'], color: habit['color'], size: 32),
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
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${habit['streak']} days',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Current streak',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsView() {
    final totalHabits = _habits.length;
    final completedToday = _habits
        .where((habit) => habit['current'] >= habit['target'])
        .length;
    final totalStreak = _habits.fold<int>(
      0,
      (sum, habit) => sum + (habit['streak'] as int),
    );
    final averageStreak = totalStreak / totalHabits;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildStatsCard(
            'Today\'s Progress',
            '$completedToday/$totalHabits',
            'habits completed',
            const Color(0xFF6366F1),
            Icons.check_circle,
          ),
          const SizedBox(height: 16),
          _buildStatsCard(
            'Total Streak',
            '${totalStreak.toInt()}',
            'days across all habits',
            const Color(0xFFF59E0B),
            Icons.local_fire_department,
          ),
          const SizedBox(height: 16),
          _buildStatsCard(
            'Average Streak',
            '${averageStreak.toStringAsFixed(1)}',
            'days per habit',
            const Color(0xFF10B981),
            Icons.trending_up,
          ),
          const SizedBox(height: 24),
          _buildHabitBreakdown(),
        ],
      ),
    );
  }

  Widget _buildStatsCard(
    String title,
    String value,
    String subtitle,
    Color color,
    IconData icon,
  ) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitBreakdown() {
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
          const Text(
            'Habit Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          ..._habits.map((habit) => _buildHabitProgressItem(habit)),
        ],
      ),
    );
  }

  Widget _buildHabitProgressItem(Map<String, dynamic> habit) {
    final progress = habit['current'] / habit['target'];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                habit['title'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                '${habit['current']}/${habit['target']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(habit['color']),
              minHeight: 8,
            ),
          ),
        ],
      ),
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

  void _showAddHabitDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final targetController = TextEditingController();
    Color selectedColor = const Color(0xFF6366F1);
    IconData selectedIcon = Icons.fitness_center;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add New Habit'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Habit Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: targetController,
                decoration: const InputDecoration(
                  labelText: 'Target (e.g., 8 glasses)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Color:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColorOption(
                    const Color(0xFF6366F1),
                    selectedColor,
                    () => selectedColor = const Color(0xFF6366F1),
                  ),
                  _buildColorOption(
                    const Color(0xFF10B981),
                    selectedColor,
                    () => selectedColor = const Color(0xFF10B981),
                  ),
                  _buildColorOption(
                    const Color(0xFFEF4444),
                    selectedColor,
                    () => selectedColor = const Color(0xFFEF4444),
                  ),
                  _buildColorOption(
                    const Color(0xFFF59E0B),
                    selectedColor,
                    () => selectedColor = const Color(0xFFF59E0B),
                  ),
                  _buildColorOption(
                    const Color(0xFF8B5CF6),
                    selectedColor,
                    () => selectedColor = const Color(0xFF8B5CF6),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  targetController.text.isNotEmpty) {
                _addHabit(
                  titleController.text,
                  descriptionController.text,
                  int.tryParse(targetController.text) ?? 1,
                  selectedColor,
                  selectedIcon,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add Habit'),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(
    Color color,
    Color selectedColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selectedColor == color
              ? Border.all(color: Colors.white, width: 3)
              : null,
          boxShadow: selectedColor == color
              ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8)]
              : null,
        ),
      ),
    );
  }

  void _addHabit(
    String title,
    String description,
    int target,
    Color color,
    IconData icon,
  ) {
    setState(() {
      _habits.add({
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': title,
        'description': description,
        'target': target,
        'current': 0,
        'streak': 0,
        'color': color,
        'icon': icon,
        'unit': 'times',
        'frequency': 'daily',
      });
    });
  }
}
