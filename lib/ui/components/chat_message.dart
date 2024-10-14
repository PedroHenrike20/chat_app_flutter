import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(this.data, this.mine);

  final Map<String, dynamic> data;
  final bool mine;

  String _formatData(Timestamp timestampData) {
    DateTime data = timestampData.toDate();
    return DateFormat('HH:mm').format(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !mine
              ? Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: CircleAvatar(
                    minRadius: 28,
                    backgroundImage: NetworkImage(data['senderPhotoUrl']),
                  ),
                )
              : Container(),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                data['imgUrl'] != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          !mine ? Text(
                            _formatData(data['time']),
                            style: TextStyle(fontSize: 14,),
                          ) : Container(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                          ),
                          Text(
                            data['senderName'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                          ),
                          mine ? Text(
                            _formatData(data['time']),
                            style: TextStyle(fontSize: 14),
                          ) : Container(),

                        ],
                      )
                    : Text(
                        data['senderName'],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                data['imgUrl'] != null
                    ? Image.network(
                        data['imgUrl'],
                        width: 250,
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          !mine
                              ? Text(
                                  _formatData(data['time']),
                                  style: TextStyle(fontSize: 14),
                                )
                              : Container(),
                          !mine
                              ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                )
                              : Container(),
                          Expanded(
                            child: Text(
                              data['text'],
                              style: const TextStyle(fontSize: 20),
                              textAlign: mine ? TextAlign.end : TextAlign.start,
                            ),
                          ),
                          mine
                              ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                )
                              : Container(),
                          mine
                              ? Text(
                                  _formatData(data['time']),
                                  style: TextStyle(fontSize: 14),
                                )
                              : Container()
                        ],
                      )
              ],
            ),
          ),
          mine
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CircleAvatar(
                    minRadius: 28,
                    backgroundImage: NetworkImage(data['senderPhotoUrl']),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
