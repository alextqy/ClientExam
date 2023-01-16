import 'package:client/models/base.dart';
import 'package:client/requests/manager_api.dart';
import 'package:flutter/widgets.dart';

// typedef WidgetConsumer<T> = Widget Function(BuildContext ctx, T vm);

// class ChangeNotifierWidget<T extends ChangeNotifier> extends StatefulWidget {
//   final T viewModel;
//   final Widget Function(BuildContext, T vm) builder;
//   const ChangeNotifierWidget(this.viewModel, this.builder, {super.key});

//   @override
//   State<StatefulWidget> createState() => ChangeNotifierState<T>();
// }

// class ChangeNotifierState<T extends ChangeNotifier>
//     extends State<ChangeNotifierWidget<T>> {
//   @override
//   void initState() {
//     super.initState();
//     // ignore: invalid_use_of_protected_member
//     assert(!widget.viewModel.hasListeners, 'no listener');
//     widget.viewModel.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     T vm = widget.viewModel;
//     return widget.builder(context, vm);
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     ///注意，这里Widget和ViewModel绑定，理论上来说当这个[StatefulWidget]对应的[StatefulElement]被移除的时候。
//     ///与他绑定的ViewModel应该也被销毁，所以这里调用了ChangeNotifier.dispose()。
//     ///还有种情况是，可能存在一个祖先ViewModel，这个Widget需要监听祖先ViewModel的数据变化，那么这里就不应该被销毁，这里暂时不考虑这种情况。
//     widget.viewModel.dispose();
//   }
// }

enum OperationStatus {
  /// 加载中
  loading,

  /// 加载成功
  success,

  /// 加载成功，但数据为空
  empty,

  /// 加载失败
  failure,

  /// 请求失败
  disconnection,
}

class BaseNotifier extends ChangeNotifier {
  late BaseModel result;
  var state = ValueNotifier(OperationStatus.loading);

  var managerApi = ManagerApi();
}
