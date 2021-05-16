import '../../models/drawer_item.dart';
import 'package:equatable/equatable.dart';

abstract class DrawerItemEvent extends Equatable {
  const DrawerItemEvent();
}

class DrawerItemClicked extends DrawerItemEvent {
  final DrawerItem item;
  DrawerItemClicked(this.item);

  @override
  List<Object> get props => [item];
  
  @override
  String toString() {
    return 'FeedbackClicked => {item : $item }';
  }
}




