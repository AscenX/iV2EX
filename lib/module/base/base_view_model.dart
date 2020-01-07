
class BaseItemViewModel {}

class BaseViewModel {

  int page = 1;

  BaseItemViewModel itemViewModel(int index, {int tag}) {
    return BaseItemViewModel();
  }
}