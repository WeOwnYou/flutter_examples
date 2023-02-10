import 'package:flutter/material.dart';
import 'package:workers_tree/src/main_view/entity/department.dart';

class WorkerWidget extends StatelessWidget {
  final Worker worker;
  final void Function() onWorkerRemoved;
  const WorkerWidget({
    Key? key,
    required this.worker,
    required this.onWorkerRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          _removeWorkerSnackBar(
            context,
            workerName: worker.name,
            onWorkerRemoved: onWorkerRemoved,
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide())),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            worker.name,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

SnackBar _removeWorkerSnackBar(
  BuildContext context, {
  required String workerName,
  required void Function() onWorkerRemoved,
}) {
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(workerName),
        Wrap(
          children: [
            IconButton(
              onPressed: () {
                onWorkerRemoved();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
