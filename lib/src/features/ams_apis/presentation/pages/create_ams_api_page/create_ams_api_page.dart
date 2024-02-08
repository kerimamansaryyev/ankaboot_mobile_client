import 'package:ankabootmobile/src/core/ui/app_layout_constraints.dart';
import 'package:ankabootmobile/src/core/ui/colors/context_color_extension.dart';
import 'package:ankabootmobile/src/core/ui/localization_extension.dart';
import 'package:ankabootmobile/src/core/ui/widgets/loader_wrapper.dart';
import 'package:ankabootmobile/src/features/ams_apis/domain/entities/ams_api_status.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/ams_apis_navigator.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/blocs/create_ams_api_bloc.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_presenter.dart';
import 'package:ankabootmobile/src/features/ams_apis/presentation/pages/create_ams_api_page/create_ams_api_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _CreateAMSAPITextFieldRecord<T> = ({
  String Function() getTitle,
  TextEditingController textEditingController,
  void Function()? selectDelegate,
  int? maxLines,
  T Function()? getValue,
});

class CreateAMSAPIPage extends StatefulWidget {
  const CreateAMSAPIPage({super.key});

  @override
  State<CreateAMSAPIPage> createState() => _CreateAMSAPIPageState();
}

class _CreateAMSAPIPageState extends State<CreateAMSAPIPage>
    implements CreateAMSAPIPageView {
  AMSAPIStatus? _selectedStatus;

  final _formKey = GlobalKey<FormState>();
  late final _presenter = CreateAMSAPIPagePresenter.fromEnv()..bindView(this);
  late final _textFieldRecords = <String, _CreateAMSAPITextFieldRecord>{
    'title': (
      getTitle: () => context.translation.createAMSAPIPageTFieldTitle,
      textEditingController: TextEditingController(),
      selectDelegate: null,
      maxLines: 1,
      getValue: null,
    ),
    'url': (
      getTitle: () => context.translation.createAMSAPIPageTFieldUrl,
      textEditingController: TextEditingController(),
      selectDelegate: null,
      maxLines: 1,
      getValue: null,
    ),
    'status': _createStatusFieldRecord(),
    'description': (
      getTitle: () => context.translation.createAMSAPIPageTFieldDescription,
      textEditingController: TextEditingController(),
      selectDelegate: null,
      maxLines: null,
      getValue: null,
    ),
  };
  final _navigator = AMSAPIsNavigator.fromEnv();

  _CreateAMSAPITextFieldRecord<AMSAPIStatus?> _createStatusFieldRecord() => (
        getTitle: () => context.translation.createAMSAPIPageTFieldStatus,
        textEditingController: TextEditingController(),
        selectDelegate: () => _navigator.showChooseAMSStatusDialog(
              context,
              selectedStatus: _selectedStatus,
              onStatusChosen: _setStatus,
            ),
        maxLines: 1,
        getValue: () => _selectedStatus,
      );

  void _setStatus(AMSAPIStatus newStatus) {
    setState(() {
      _selectedStatus = newStatus;
      _textFieldRecords['status']?.textEditingController.text =
          newStatus.name.toUpperCase();
    });
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    FocusScope.of(context).unfocus();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _presenter.createAMSAPI(
        title: _textFieldRecords['title']!.textEditingController.text,
        description:
            _textFieldRecords['description']!.textEditingController.text,
        url: _textFieldRecords['url']!.textEditingController.text,
        status: _selectedStatus!,
      );
    });
  }

  @override
  void showErrorDialog(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  @override
  void popScreen() {
    _navigator.appNavigator.pop(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _presenter.buildMultiBlocListener(
      context,
      BlocBuilder<BlocBase<CreateAMSAPIState>, CreateAMSAPIState>(
        bloc: _presenter.createAMSAPIBloc(),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: context.colors.homePageScaffoldColor,
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => _navigator.appNavigator.pop(),
              ),
              title: Text(context.translation.createAMSAPIPageTitle),
            ),
            body: LoadWrapper(
              isLoading: state is CreateAMSAPILoading,
              child: SafeArea(
                top: false,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1.gap,
                    vertical: 1.gap,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        for (final tFieldRecord in _textFieldRecords.values)
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 1.25.gap,
                            ),
                            child: Builder(
                              builder: (context) {
                                return TextFormField(
                                  controller:
                                      tFieldRecord.textEditingController,
                                  onTap: tFieldRecord.selectDelegate,
                                  readOnly: tFieldRecord.selectDelegate != null,
                                  maxLines: tFieldRecord.maxLines,
                                  validator: (value) => value == null ||
                                          value.trim().isEmpty
                                      ? context.translation.textFieldRequired
                                      : null,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: tFieldRecord.getTitle(),
                                    border: const OutlineInputBorder(),
                                    suffixIcon:
                                        tFieldRecord.selectDelegate == null
                                            ? null
                                            : const Icon(
                                                Icons.arrow_drop_down,
                                              ),
                                  ),
                                );
                              },
                            ),
                          ),
                        0.5.hBox,
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                  ),
                                ),
                                onPressed: _onSubmit,
                                icon: const Icon(
                                  Icons.add,
                                ),
                                label: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 0.8.gap,
                                  ),
                                  child: Text(
                                    context.translation.homePageAddAPI,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
