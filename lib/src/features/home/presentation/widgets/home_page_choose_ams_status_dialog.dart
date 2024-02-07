import 'dart:math';

import 'package:adaptix/adaptix.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:ankabootmobile/src/core/ui/widgets/app_dialog.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/home/presentation/home_navigator.dart';
import 'package:flutter/material.dart';

class HomePageChooseAMASStatusDialog extends StatelessWidget {
  final AMSAPIStatus? selectedStatus;
  final HomePageChooseAMSStatusDialogOnStatusChosen onStatusChosen;

  const HomePageChooseAMASStatusDialog({
    required this.selectedStatus,
    required this.onStatusChosen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: Text(
        context.translation.homePageAMSAssignNewStatus,
      ),
      content: SizedBox(
        width: min(
          100.widthFraction(context),
          500,
        ),
        child: Column(
          children: [
            for (final status in AMSAPIStatus.displayValues)
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<AMSAPIStatus>(
                      title: Text(
                        status.name.toUpperCase(),
                      ),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: status,
                      groupValue: selectedStatus,
                      toggleable: false,
                      onChanged: (newStatus) {
                        if (newStatus == null) {
                          return;
                        }
                        onStatusChosen(newStatus);
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            MaterialLocalizations.of(context).closeButtonLabel,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            ),
          ),
        ),
      ],
    );
  }
}
