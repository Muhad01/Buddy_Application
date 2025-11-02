import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedPriority = 'medium';
  String _selectedTaskType = 'One time task';
  String _selectedDueDate = '';
  String _selectedNotificationTime = '';
  bool _enableNotification = false;
  bool _enableMessage = false;
  bool _noTimeLimit = false;
  Set<String> _selectedDays = <String>{};

  final List<String> _daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  final List<String> _taskTypes = [
    'Daily task',
    'One time task',
    'Weekly task',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputFields(),
                    const SizedBox(height: 24),
                    _buildPrioritySection(),
                    const SizedBox(height: 24),
                    _buildTaskTypeSection(),
                    const SizedBox(height: 24),
                    _buildDateAndTimeSection(),
                    if (_selectedTaskType == 'Weekly task') ...[
                      const SizedBox(height: 24),
                      _buildDaysOfWeekSection(),
                    ],
                    if (_selectedTaskType == 'Daily task' ||
                        _selectedTaskType == 'One time task' ||
                        _selectedTaskType == 'Weekly task') ...[
                      const SizedBox(height: 24),
                      _buildNotificationMessageSection(),
                    ],
                    const SizedBox(height: 40),
                    _buildAddTaskButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          controller: _titleController,
          icon: Icons.title,
          placeholder: 'Task Title',
          maxLines: 1,
        ),
        const SizedBox(height: 16),
        _buildInputField(
          controller: _descriptionController,
          icon: Icons.description,
          placeholder: 'Description',
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String placeholder,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPrioritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Priority', style: AppTextStyles.labelLarge),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildPriorityButton(
                'Low',
                AppColors.lowPriority,
                _selectedPriority == 'low',
                () => setState(() => _selectedPriority = 'low'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildPriorityButton(
                'Medium',
                AppColors.mediumPriority,
                _selectedPriority == 'medium',
                () => setState(() => _selectedPriority = 'medium'),
                showCheckmark: true,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildPriorityButton(
                'High',
                AppColors.highPriority,
                _selectedPriority == 'high',
                () => setState(() => _selectedPriority = 'high'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityButton(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap, {
    bool showCheckmark = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected && showCheckmark)
                const Icon(Icons.check, color: Colors.white, size: 16),
              if (isSelected && showCheckmark) const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Task Type', style: AppTextStyles.labelLarge),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedTaskType,
              isExpanded: true,
              items: _taskTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      type,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedTaskType = newValue;
                    // Reset notification/message options when switching away from Daily task, One time task, and Weekly task
                    if (newValue != 'Daily task' &&
                        newValue != 'One time task' &&
                        newValue != 'Weekly task') {
                      _enableNotification = false;
                      _enableMessage = false;
                    }
                    // Reset no time limit when switching away from One time task
                    if (newValue != 'One time task') {
                      _noTimeLimit = false;
                      // Clear date and time when switching away from One time task
                      if (newValue != 'Daily task' &&
                          newValue != 'Weekly task') {
                        _selectedDueDate = '';
                        _selectedNotificationTime = '';
                      }
                    } else if (_noTimeLimit) {
                      // Clear date and time when switching to One time task with no time limit
                      _selectedDueDate = '';
                      _selectedNotificationTime = '';
                    }
                    // Reset selected days when switching away from Weekly task
                    if (newValue != 'Weekly task') {
                      _selectedDays.clear();
                    }
                    // Clear time when switching to/from task types that require time
                    if (newValue != 'Daily task' &&
                        newValue != 'Weekly task' &&
                        newValue != 'One time task') {
                      _selectedNotificationTime = '';
                    }
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateAndTimeSection() {
    if (_selectedTaskType == 'Daily task') {
      // Only show time for daily task (required)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Time', style: AppTextStyles.labelLarge),
              Text(' *', style: TextStyle(color: AppColors.error)),
            ],
          ),
          const SizedBox(height: 12),
          _buildDateTimeField(
            icon: Icons.access_time,
            placeholder: 'Select Time (Required)',
            value: _selectedNotificationTime,
            onTap: _selectNotificationTime,
          ),
        ],
      );
    } else if (_selectedTaskType == 'One time task') {
      // Show both date and time for one time task (both required, unless no time limit)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNoTimeLimitButton(),
          if (!_noTimeLimit) ...[
            const SizedBox(height: 12),
            const Row(
              children: [
                Text('Date and Time', style: AppTextStyles.labelLarge),
                Text(' *', style: TextStyle(color: AppColors.error)),
              ],
            ),
            const SizedBox(height: 12),
            _buildDateTimeField(
              icon: Icons.calendar_today,
              placeholder: 'Select Due Date (Required)',
              value: _selectedDueDate,
              onTap: _selectDueDate,
            ),
            const SizedBox(height: 16),
            _buildDateTimeField(
              icon: Icons.access_time,
              placeholder: 'Select Time (Required)',
              value: _selectedNotificationTime,
              onTap: _selectNotificationTime,
            ),
          ],
        ],
      );
    } else if (_selectedTaskType == 'Weekly task') {
      // Show only time for weekly task (required)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Time', style: AppTextStyles.labelLarge),
              Text(' *', style: TextStyle(color: AppColors.error)),
            ],
          ),
          const SizedBox(height: 12),
          _buildDateTimeField(
            icon: Icons.access_time,
            placeholder: 'Select Time (Required)',
            value: _selectedNotificationTime,
            onTap: _selectNotificationTime,
          ),
        ],
      );
    } else {
      // Show both date and time for other task types (optional)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateTimeField(
            icon: Icons.calendar_today,
            placeholder: 'Select Due Date',
            value: _selectedDueDate,
            onTap: _selectDueDate,
          ),
          const SizedBox(height: 16),
          _buildDateTimeField(
            icon: Icons.access_time,
            placeholder: 'Select Notification Time',
            value: _selectedNotificationTime,
            onTap: _selectNotificationTime,
          ),
        ],
      );
    }
  }

  Widget _buildDaysOfWeekSection() {
    if (_daysOfWeek.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text('Days of Week', style: AppTextStyles.labelLarge),
            Text(' *', style: TextStyle(color: AppColors.error)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_daysOfWeek.length, (index) {
              final day = _daysOfWeek[index];
              final isSelected = _selectedDays.contains(day);
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 4,
                    right: index == _daysOfWeek.length - 1 ? 0 : 4,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedDays.remove(day);
                        } else {
                          _selectedDays.add(day);
                        }
                      });
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildNoTimeLimitButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _noTimeLimit = !_noTimeLimit;
          if (_noTimeLimit) {
            // Clear date and time when selecting no time limit
            _selectedDueDate = '';
            _selectedNotificationTime = '';
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: _noTimeLimit,
                onChanged: (value) {
                  setState(() {
                    _noTimeLimit = value ?? false;
                    if (_noTimeLimit) {
                      // Clear date and time when selecting no time limit
                      _selectedDueDate = '';
                      _selectedNotificationTime = '';
                    }
                  });
                },
                activeColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'No time limit',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeField({
    required IconData icon,
    required String placeholder,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value.isEmpty ? placeholder : value,
                  style: TextStyle(
                    color: value.isEmpty
                        ? Colors.grey.shade500
                        : AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text('Notification Options', style: AppTextStyles.labelLarge),
            Text(' *', style: TextStyle(color: AppColors.error)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildNotificationButton(
                'Notification',
                AppColors.primary,
                _enableNotification,
                () {
                  setState(() => _enableNotification = !_enableNotification);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildNotificationButton(
                'Message',
                AppColors.primary,
                _enableMessage,
                () {
                  setState(() => _enableMessage = !_enableMessage);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationButton(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                const Icon(Icons.check, color: Colors.white, size: 16),
              if (isSelected) const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: _addTask,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDueDate = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _selectNotificationTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedNotificationTime = picked.format(context);
      });
    }
  }

  void _addTask() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a task title'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Time is required for Daily task
    if (_selectedTaskType == 'Daily task' &&
        _selectedNotificationTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a time for daily task'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Date and time are required for One time task (unless no time limit)
    if (_selectedTaskType == 'One time task' && !_noTimeLimit) {
      if (_selectedDueDate.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a due date for one time task'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      if (_selectedNotificationTime.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a time for one time task'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }

    // Weekly task validations
    if (_selectedTaskType == 'Weekly task') {
      if (_selectedDays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one day of the week'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      if (_selectedNotificationTime.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a time for weekly task'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }

    // At least one notification option is required for Daily task, One time task, and Weekly task
    if ((_selectedTaskType == 'Daily task' ||
            _selectedTaskType == 'One time task' ||
            _selectedTaskType == 'Weekly task') &&
        !_enableNotification &&
        !_enableMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select at least one notification option (Notification or Message)',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Here you would typically save the task to your data source
    // For now, we'll just show a success message and go back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task added successfully!'),
        backgroundColor: AppColors.success,
      ),
    );

    Navigator.pop(context);
  }
}
