import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:moon_dap/app/resources/uiConfig/color_config.dart';
import 'package:moon_dap/presentation/base/base_view_model.dart';
import 'package:provider/provider.dart';

@immutable
abstract class BaseScreen<T extends BaseViewModel> extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => createViewModel(),
      lazy: !hasOnInitEvent,
      builder: (BuildContext context, Widget? child) {
        return ConditionalWillPopScope(
          shouldAddCallback: preventSwipeBack,
          onWillPop: () async {
            return false;
          },
          child: Container(
            color: unSafeAreaColor,
            child: wrapWithSafeArea
                ? SafeArea(child: _buildScaffold(context))
                : _buildScaffold(context),
          ),
        );
      },
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      extendBody: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: buildScreen(context),
      backgroundColor: screenBackgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: buildFloatingActionButton,
    );
  }

  @protected
  Color? get unSafeAreaColor => AppColor.black;

  @protected
  bool get resizeToAvoidBottomInset => true;

  @protected
  Widget? get buildFloatingActionButton => null;

  @protected
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  @protected
  bool get extendBodyBehindAppBar => false;

  @protected
  bool get preventSwipeBack => false;

  @protected
  Color? get screenBackgroundColor => AppColor.black;

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @protected
  Widget buildScreen(BuildContext context);

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @protected
  bool get wrapWithSafeArea => true;

  @protected
  bool get hasOnInitEvent => true;

  @protected
  bool get setBottomSafeArea => true;

  @protected
  bool get setTopSafeArea => true;

  @protected
  T vm(BuildContext context) => Provider.of<T>(context, listen: false);

  @protected
  T createViewModel();
}