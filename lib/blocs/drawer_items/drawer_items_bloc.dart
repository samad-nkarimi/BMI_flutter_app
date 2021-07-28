import 'package:bloc/bloc.dart';
import 'package:BMI/blocs/blocs.dart';
import '../../models/drawer_item.dart';

class DrawerItemsBloc extends Bloc<DrawerItemEvent, DrawerItem> {
  DrawerItemsBloc() : super(DrawerItem.nothing);

  @override
  Stream<DrawerItem> mapEventToState(DrawerItemEvent event) async* {
    if (event is DrawerItemClicked) {
      yield event.item;
    }
  }
}

//   if (event.item  is 0) {
//   yield _mapClickToSendEmail();
// } else if (event.item is 1) {
//   yield _mapClickToShareAppLink();
// } else if (event.ite is 2) {
//   yield _mapClickToOpenAppAccont();
// } else if (event.item is 3) {
//   yield _mapClickToOpenAboutUs();
// }

//    _mapClickToSendEmail() {}

// _mapClickToShareAppLink() {}

// _mapClickToOpenAppAccont() {}

// _mapClickToOpenAboutUs() {}
