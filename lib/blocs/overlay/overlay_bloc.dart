import 'package:BMI/blocs/blocs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverlayColorState extends Equatable {
  final Color color;

  OverlayColorState(this.color);
  @override
  List<Object> get props => [color];
}

class OverlayCubit extends Cubit<OverlayColorState> {
  final Themetype themetype;
  List<Color> colors = [Colors.blue, Colors.green, Colors.orange, Colors.red];

  OverlayCubit(this.themetype) : super(OverlayColorState(Colors.green));

  void setOverlayColor(int index) => emit(OverlayColorState(colors[index]));

  Color getTransparentColor(Themetype themetype) {
    if (themetype == Themetype.dark) {
      return Colors.transparent;
    } else {
      return Colors.white.withOpacity(0.01);
    }
  }
}
