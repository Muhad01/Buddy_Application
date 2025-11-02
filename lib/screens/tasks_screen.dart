import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _tasks = [
    {
      'id': 1,
      'title': 'Morning Workout',
      'description': '30 minutes of cardio and strength training',
      'time': '7:00 AM',
      'priority': 'high',
      'completed': false,
      'category': 'Health',
    },
    {
      'id': 2,
      'title': 'Team Meeting',
      'description': 'Weekly standup with the development team',
      'time': '10:00 AM',
      'priority': 'medium',
      'completed': true,
      'category': 'Work',
    },
    {
      'id': 3,
      'title': 'Grocery Shopping',
      'description': 'Buy ingredients for the week',
      'time': '2:00 PM',
      'priority': 'low',
      'completed': false,
      'category': 'Personal',
    },
    {
      'id': 4,
      'title': 'Project Review',
      'description': 'Review and finalize the mobile app design',
      'time': '3:00 PM',
      'priority': 'high',
      'completed': false,
      'category': 'Work',
    },
    {
      'id': 5,
      'title': 'Read Books',
      'description': 'Read 30 pages of "Atomic Habits"',
      'time': '8:00 PM',
      'priority': 'medium',
      'completed': false,
      'category': 'Learning',
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
                  _buildTaskList('all'),
                  _buildTaskList('pending'),
                  _buildTaskList('completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Tasks',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_tasks.where((task) => !task['completed']).length} pending tasks',
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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(4),
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
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6366F1),
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Pending'),
          Tab(text: 'Completed'),
        ],
      ),
    );
  }

  Widget _buildTaskList(String filter) {
    List<Map<String, dynamic>> filteredTasks = _tasks.where((task) {
      switch (filter) {
        case 'pending':
          return !task['completed'];
        case 'completed':
          return task['completed'];
        default:
          return true;
      }
    }).toList();

    if (filteredTasks.isEmpty) {
      return _buildEmptyState(filter);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];
        return _buildTaskCard(task);
      },
    );
  }

  Widget _buildEmptyState(String filter) {
    String message;
    IconData icon;

    switch (filter) {
      case 'pending':
        message = 'No pending tasks';
        icon = Icons.task_alt;
        break;
      case 'completed':
        message = 'No completed tasks';
        icon = Icons.check_circle;
        break;
      default:
        message = 'No tasks yet';
        icon = Icons.task;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first task',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _toggleTaskCompletion(task),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildPriorityIndicator(task['priority']),
                const SizedBox(width: 12),
                _buildTaskContent(task),
                const SizedBox(width: 12),
                _buildTaskActions(task),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator(String priority) {
    Color color;
    switch (priority) {
      case 'high':
        color = const Color(0xFFEF4444);
        break;
      case 'medium':
        color = const Color(0xFFF59E0B);
        break;
      default:
        color = const Color(0xFF10B981);
    }

    return Container(
      width: 4,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildTaskContent(Map<String, dynamic> task) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: task['completed']
                        ? Colors.grey[600]
                        : const Color(0xFF1E293B),
                    decoration: task['completed']
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(task['category']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task['category'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getCategoryColor(task['category']),
                  ),
                ),
              ),
            ],
          ),
          if (task['description'].isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              task['description'],
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                task['time'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskActions(Map<String, dynamic> task) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _toggleTaskCompletion(task),
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: task['completed']
                  ? const Color(0xFF10B981)
                  : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: task['completed']
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showTaskOptions(task),
          child: Icon(Icons.more_vert, size: 20, color: Colors.grey[500]),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return const Color(0xFF6366F1);
      case 'health':
        return const Color(0xFF10B981);
      case 'personal':
        return const Color(0xFF8B5CF6);
      case 'learning':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  void _toggleTaskCompletion(Map<String, dynamic> task) {
    setState(() {
      task['completed'] = !task['completed'];
    });
  }

  void _showTaskOptions(Map<String, dynamic> task) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF6366F1)),
              title: const Text('Edit Task'),
              onTap: () {
                Navigator.pop(context);
                _showEditTaskDialog(task);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Color(0xFFEF4444)),
              title: const Text('Delete Task'),
              onTap: () {
                Navigator.pop(context);
                _deleteTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTaskDialog(Map<String, dynamic> task) {
    _showTaskDialog(task: task);
  }

  void _showTaskDialog({Map<String, dynamic>? task}) {
    final titleController = TextEditingController(text: task?['title'] ?? '');
    final descriptionController = TextEditingController(
      text: task?['description'] ?? '',
    );
    final timeController = TextEditingController(text: task?['time'] ?? '');
    String selectedPriority = task?['priority'] ?? 'medium';
    String selectedCategory = task?['category'] ?? 'Personal';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(task == null ? 'Add New Task' : 'Edit Task'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
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
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Time (e.g., 7:00 AM)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'low', child: Text('Low')),
                  DropdownMenuItem(value: 'medium', child: Text('Medium')),
                  DropdownMenuItem(value: 'high', child: Text('High')),
                ],
                onChanged: (value) => selectedPriority = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Work', child: Text('Work')),
                  DropdownMenuItem(value: 'Health', child: Text('Health')),
                  DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                  DropdownMenuItem(value: 'Learning', child: Text('Learning')),
                ],
                onChanged: (value) => selectedCategory = value!,
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
              if (titleController.text.isNotEmpty) {
                if (task == null) {
                  _addTask(
                    titleController.text,
                    descriptionController.text,
                    timeController.text,
                    selectedPriority,
                    selectedCategory,
                  );
                } else {
                  _updateTask(
                    task,
                    titleController.text,
                    descriptionController.text,
                    timeController.text,
                    selectedPriority,
                    selectedCategory,
                  );
                }
                Navigator.pop(context);
              }
            },
            child: Text(task == null ? 'Add Task' : 'Update Task'),
          ),
        ],
      ),
    );
  }

  void _addTask(
    String title,
    String description,
    String time,
    String priority,
    String category,
  ) {
    setState(() {
      _tasks.add({
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': title,
        'description': description,
        'time': time,
        'priority': priority,
        'completed': false,
        'category': category,
      });
    });
  }

  void _updateTask(
    Map<String, dynamic> task,
    String title,
    String description,
    String time,
    String priority,
    String category,
  ) {
    setState(() {
      task['title'] = title;
      task['description'] = description;
      task['time'] = time;
      task['priority'] = priority;
      task['category'] = category;
    });
  }

  void _deleteTask(Map<String, dynamic> task) {
    setState(() {
      _tasks.remove(task);
    });
  }
}
