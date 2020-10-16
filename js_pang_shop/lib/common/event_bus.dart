import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class CategoryLeftClickEvent {
  final int index;
  CategoryLeftClickEvent(this.index);
}

