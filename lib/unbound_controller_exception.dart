class UnboundControllerException implements Exception {
  @override
  String toString() {
    return 'UnboundControllerException: Controller is not bound to a widget.';
  }
}
