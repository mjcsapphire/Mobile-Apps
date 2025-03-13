import 'dart:io';

import 'package:fcfs_banking_app/core/theme/colors.dart';
import 'package:fcfs_banking_app/core/theme/radialBg.dart';
import 'package:fcfs_banking_app/core/utils/app_helpers.dart';
import 'package:fcfs_banking_app/src/controllers/idea_submission_controller.dart';
import 'package:fcfs_banking_app/src/controllers/theme_controller.dart';
import 'package:fcfs_banking_app/src/controllers/user_controller.dart';
import 'package:fcfs_banking_app/src/models/community_funding_model.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_app_bar.dart';
import 'package:fcfs_banking_app/src/views/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class IdeaSubmissionForm extends StatefulWidget {
  final IdeaSubmissionModel? idea;
  const IdeaSubmissionForm({super.key, this.idea});

  @override
  State<IdeaSubmissionForm> createState() => _IdeaSubmissionFormState();
}

class _IdeaSubmissionFormState extends State<IdeaSubmissionForm> {
  TextEditingController _headlineController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _highlightsController = TextEditingController();
  TextEditingController _purposeController = TextEditingController();
  TextEditingController _targetAmountController = TextEditingController();
  TextEditingController _raisedAmountController = TextEditingController();
  TextEditingController _minimumInvestmentController = TextEditingController();
  TextEditingController _equityOfferedController = TextEditingController();
  final TextEditingController _maximumInvestmentController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final IdeaSubmissionController ideaSubmissionController =
      Get.find<IdeaSubmissionController>();
  final UserController userController = Get.find<UserController>();
  final ThemeController themeController = Get.find<ThemeController>();

  String? existingThumbnailUrl;

  XFile? _thumbnail;
  String _investorRole = 'Equity';
  String _stage = 'Idea Stage (Concept/Prototype)';

  // Dropdown options
  List<String> investorRoles = ['Equity', 'Dividend'];
  List<String> stages = [
    'Idea Stage (Concept/Prototype)',
    'Early Stage (Operational, pre-revenue)',
    'Growth Stage (Operational with revenue)'
  ];
  @override
  void initState() {
    super.initState();
    final idea = widget.idea;
    _headlineController = TextEditingController(text: idea?.headline ?? '');
    _descriptionController =
        TextEditingController(text: idea?.description ?? '');
    _highlightsController = TextEditingController(text: idea?.highlights ?? '');
    _purposeController = TextEditingController(text: idea?.purpose ?? '');
    _targetAmountController =
        TextEditingController(text: idea?.targetAmount.toString() ?? '');
    _raisedAmountController =
        TextEditingController(text: idea?.raisedAmount.toString() ?? '');
    _minimumInvestmentController =
        TextEditingController(text: idea?.minimumInvestment.toString() ?? '');
    _equityOfferedController =
        TextEditingController(text: idea?.equityOffered.toString() ?? '');
    _equityOfferedController =
        TextEditingController(text: idea?.maximumInvestment.toString() ?? '');

    _investorRole = idea?.investorRole ?? 'Equity';
    _stage = idea?.stage ?? 'Idea Stage (Concept/Prototype)';
    existingThumbnailUrl = idea?.thumbnailUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Idea Submission",
        showMoreVertIcon: false,
        showNotificationIcon: false,
        showProfilePic: false,
        onMoreVertTap: () {},
      ),
      body: Stack(
        children: [
          // Black background
          CustomPaint(
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
            painter: themeController.themeMode == ThemeMode.dark
                ? DarkGradientBackgroundPainter()
                : GradientBackgroundPainter(),
          ),

          // Form Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnail Picker
                    GestureDetector(
                      onTap: _pickThumbnail,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.white.withOpacity(0.4),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 20.h,
                        child: _thumbnail != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(_thumbnail!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : existingThumbnailUrl != null &&
                                    existingThumbnailUrl!.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      existingThumbnailUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Tap to select thumbnail (Image/Video)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Headline
                    _buildTextField(_headlineController, 'Project Name'),
                    SizedBox(height: 1.h),

                    // Description
                    _buildTextField(_descriptionController, 'Description',
                        maxLines: 4),
                    SizedBox(height: 1.h),

                    // Highlights
                    _buildTextField(
                        _highlightsController, 'Highlights (comma separated)',
                        maxLines: 4),
                    SizedBox(height: 1.h),

                    // Purpose of Funding
                    _buildTextField(_purposeController, 'Purpose of Funding',
                        maxLines: 2),
                    SizedBox(height: 1.h),

                    // Target Amount
                    _buildTextField(_targetAmountController, 'Target Amount',
                        isNumber: true),
                    SizedBox(height: 1.h),

                    // Minimum Investment Amount
                    _buildTextField(_minimumInvestmentController,
                        'Minimum Investment Amount',
                        isNumber: true),
                    SizedBox(height: 1.h),

                    _buildTextField(_maximumInvestmentController,
                        'Maximum Investment Amount',
                        isNumber: true),
                    SizedBox(height: 1.h),

                    _buildTextField(
                        _raisedAmountController, 'Investment Raised (So Far)',
                        isNumber: true, enabled: true),
                    SizedBox(height: 1.h),

                    // Investor Role Dropdown
                    _buildDropdown(
                        investorRoles, _investorRole, 'Investor Role', (value) {
                      setState(() {
                        _investorRole = value!;
                      });
                    }),
                    SizedBox(height: 1.h),

                    // Equity Offered
                    _buildTextField(
                        _equityOfferedController, 'Equity Offered (%)',
                        isNumber: true),
                    SizedBox(height: 1.h),

                    // Stage Dropdown
                    _buildDropdown(stages, _stage, 'Stage', (value) {
                      setState(() {
                        _stage = value!;
                      });
                    }),
                    SizedBox(height: 7.5.h),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Obx(
              () => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ideaSubmissionController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: AppColors.pinkColor,
                        )
                      : CustomButtonWidget(
                          onTap: () {
                            _submitForm(userController.user.value!.uid);
                          },
                          width: MediaQuery.of(context).size.width,
                          text: "Submit",
                          isIconAvailable: false,
                          fontSize: 18.sp,
                          color: themeController.themeMode == ThemeMode.dark
                              ? AppColors.darkBorderColor
                              : AppColors.red,
                          borderColor:
                              themeController.themeMode == ThemeMode.dark
                                  ? AppColors.darkBorderColor
                                  : AppColors.red,
                          radius: 10,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a TextField
  Widget _buildTextField(TextEditingController? controller, String label,
      {int maxLines = 1, bool isNumber = false, bool enabled = true}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      keyboardType: isNumber
          ? TextInputType.number
          : (label == 'Description'
              ? TextInputType.multiline
              : TextInputType.text),
      decoration: InputDecoration(
        labelText: label,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pinkColor, width: 0.5),
        ),
        errorStyle: Theme.of(context)
            .textTheme
            .displaySmall
            ?.copyWith(color: AppColors.pinkColor),
        labelStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 17.sp),
        fillColor: AppColors.textEditingBoxColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white.withOpacity(0.5)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pinkColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[600]!),
        ),
      ),
      style: Theme.of(context).textTheme.displayMedium,
    );
  }

  // Helper method to build Dropdown
  Widget _buildDropdown(List<String> items, String value, String label,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context)
            .textTheme
            .displayMedium
            ?.copyWith(fontSize: 17.sp),
        fillColor: AppColors.textEditingBoxColor,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pinkColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white.withOpacity(0.5)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[600]!),
        ),
      ),
      dropdownColor: AppColors.pinkColor,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  // Function to pick thumbnail (Image/Video)
  Future<void> _pickThumbnail() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _thumbnail = pickedFile;
      existingThumbnailUrl = null;
    });
  }

  // Function to handle form submission
  void _submitForm(String userId) {
    if (_thumbnail == null &&
        (existingThumbnailUrl == null || existingThumbnailUrl!.isEmpty)) {
      AppHelpers.toast('Please select a thumbnail');
      return;
    }
    if (_formKey.currentState!.validate() && _thumbnail != null) {
      final idea = IdeaSubmissionModel(
        id: widget.idea?.id ?? '',
        businessOwner:
            '${userController.user.value!.firstName} ${userController.user.value!.lastName}',
        userId: userId,
        headline: _headlineController.text,
        description: _descriptionController.text,
        highlights: _highlightsController.text,
        purpose: _purposeController.text,
        targetAmount: double.parse(_targetAmountController.text),
        raisedAmount: double.parse(_raisedAmountController.text),
        minimumInvestment: double.parse(_minimumInvestmentController.text),
        equityOffered: double.parse(_equityOfferedController.text),
        investorRole: _investorRole,
        stage: _stage,
        thumbnailUrl: existingThumbnailUrl ?? '',
        createdAt: DateTime.now(),
        targetdDate: DateTime(DateTime.now().year + 1),
        maximumInvestment: double.parse(_maximumInvestmentController.text),
        totalInvestors: 0,
      );

      // ideaSubmissionController.submitIdea(idea, File(_thumbnail!.path));
      if (widget.idea != null) {
        ideaSubmissionController.updateIdea(
            idea, _thumbnail != null ? File(_thumbnail!.path) : File(''));
      } else {
        ideaSubmissionController.submitIdea(idea, File(_thumbnail!.path));
      }
    }
  }
}
