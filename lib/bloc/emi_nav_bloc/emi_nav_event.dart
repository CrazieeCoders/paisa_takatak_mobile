import 'emi_nav_state.dart';

abstract class EmiNavDrawerEvent{
  const EmiNavDrawerEvent();
}

class NavigateTo extends EmiNavDrawerEvent{

  final NavItem destination;

  const NavigateTo(this.destination);

}
