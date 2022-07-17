import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeDark());

  void changeTheme() {
    emit(state is ThemeDark ? ThemeLight() : ThemeDark());
  }
}