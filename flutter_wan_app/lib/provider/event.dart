import 'package:flutter/material.dart';

enum StatusEventType { success, faild, noMore }
enum StatusEventLoadType { header, footer }

class StatusEvent {
  String labelId;
  StatusEventType status;
  StatusEventLoadType loadType;
  int cid;

  StatusEvent(this.labelId, this.status, {this.cid, this.loadType});
}
