import 'package:evently_c18/common/utils/shared_container_decoration.dart';
import 'package:evently_c18/common/utils/validation_utils.dart';
import 'package:evently_c18/common/widgets/custom_filled_button.dart';
import 'package:evently_c18/common/widgets/custom_text_field.dart';
import 'package:evently_c18/models/event_model.dart';
import 'package:evently_c18/network/event_service.dart';
import 'package:evently_c18/screens/events/add_new_event/category_row_widget.dart';
import 'package:evently_c18/screens/events/provider/events_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});
  static const String routeName = "/add_new_event_screen";
  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _description = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => EventsProvider(),
      child: Form(
        key: _globalKey,
        child: Consumer<EventsProvider>(
          builder:
              (BuildContext context, EventsProvider provider, Widget? child) {
                return Scaffold(
                  appBar: AppBar(title: Text("Add event")),
                  body: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 16,
                        children: [
                          Container(
                            decoration:
                                SharedContainerDecoration.decorationWithBorder(
                                  theme,
                                ),

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                provider.selectedCategory.image,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          CustomCategoryRow(),
                          CustomTextField(
                            hintText: "Event title",
                            titleText: "Title",
                            controller: _titleController,
                            validator: (value) =>
                                ValidationUtils.validateEmptyText(value)
                                ? null
                                : "title is required", //TODO:localizatio
                          ),
                          CustomTextField(
                            titleText: "Description",
                            hintText: "Event Description....",
                            maxLines: 5,
                            controller: _description,

                            validator: (value) =>
                                ValidationUtils.validateEmptyText(value)
                                ? null
                                : "discretion is required", //TODO:localizatio
                          ),
                          _drawDateTimeRow(
                            Icons.date_range_outlined,
                            "Event Date",
                            _getDate(provider),
                            () async {
                              DateTime? returnedValue = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                initialDate: DateTime.now(),
                              );
                              if (returnedValue != null) {
                                provider.editDate(returnedValue);
                              }
                              if (context.mounted) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode());
                              }
                            },
                          ),
                          _drawDateTimeRow(
                            Icons.date_range_outlined,
                            "Event Time",
                            _getTime(provider),
                            () async {
                              TimeOfDay? returnedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (returnedTime != null) {
                                provider.editTime(returnedTime);
                              }

                              if (context.mounted) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode());
                              }
                            },
                          ),
                          CustomFilledButton(
                            isLoading: isLoading,
                            text: "Add event",
                            onPressed: () async {
                              if (_validateForm(provider)) {
                                setState(() {
                                  isLoading = true;
                                });
                                DateTime date = provider.selectedDate!;
                                date = date.copyWith(
                                  hour: provider.selectedTime!.hour,
                                  minute: provider.selectedTime!.minute,
                                );

                                EventModel eventModel = EventModel(
                                  catId: provider.selectedCategory.id,
                                  date: date,
                                  description: _description.text,
                                  title: _titleController.text,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                );
                                String? errorMessage =
                                    await EventService.createNewEvent(
                                      eventModel,
                                    );
                                setState(() {
                                  isLoading = false;
                                });
                                if (errorMessage != null) {
                                  Fluttertoast.showToast(
                                    msg: errorMessage,
                                    backgroundColor: Colors.red,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Event Added successful",
                                  );
                                  if (context.mounted) {
                                    // Navigator.of(context).pop(true);
                                    Navigator.pop(context, true);
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
        ),
      ),
    );
  }

  bool _validateForm(EventsProvider provider) {
    if (!_globalKey.currentState!.validate()) {
      return false;
    } else {
      if (provider.selectedDate == null) {
        Fluttertoast.showToast(msg: "Date is required");
        return false;
      }
      if (provider.selectedTime == null) {
        Fluttertoast.showToast(msg: "Time is required");
        return false;
      }

      return true;
    }
  }

  _getDate(EventsProvider provider) {
    if (provider.selectedDate == null) {
      return "select";
    } else {
      return "${provider.selectedDate!.year}/${provider.selectedDate!.month}/${provider.selectedDate!.day}";
    }
  }

  _getTime(EventsProvider provider) {
    if (provider.selectedTime == null) {
      return "select";
    } else {
      return provider.selectedTime!.format(context);
    }
  }

  ListTile _drawDateTimeRow(
    IconData icon,
    String title,
    String trailingTitle,
    void Function() onSelect,
  ) {
    ThemeData theme = Theme.of(context);

    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.all(0),
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleMedium),
      trailing: TextButton(
        onPressed: onSelect,
        child: Text(
          trailingTitle,
          style: theme.textTheme.labelSmall!.copyWith(
            color: theme.colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
