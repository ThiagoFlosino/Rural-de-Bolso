import 'package:mobx/mobx.dart';

part 'DashboardStore.g.dart';

class DashboardStore = _DashboardStore with _$DashboardStore;

abstract class _DashboardStore with Store {
  @observable
  int index = 0;

  @action
  setIndex(value) {
    index = value;
  }
}
