import 'package:flutter/material.dart';
import 'package:wtech_dashboard/responsiveness.dart';

import '../../../../core/theme/colors.dart';

class OrdersData extends StatefulWidget {
  const OrdersData({
    Key? key,
    required this.orderId,
    required this.customerName,
    required this.customerEmail,
    required this.totalPrice,
    required this.orderStatus,
    required this.orderDate,
    this.onPressed,
    required this.color,
  }) : super(key: key);
  final String orderId;
  final String customerName;
  final String customerEmail;
  final double totalPrice;
  final String orderStatus;
  final Color color;
  final String orderDate;
  final VoidCallback? onPressed;

  @override
  State<OrdersData> createState() => _OrdersDataState();
}

class _OrdersDataState extends State<OrdersData> {
  ScrollController controller1 = ScrollController();
  @override
  void dispose() {
    controller1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Scrollbar(
        controller: controller1,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: controller1,
          scrollDirection: Axis.horizontal,
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: const DividerThemeData(color: Colors.transparent),
            ),
            child: DataTable(
              showBottomBorder: false,
              headingRowHeight: 0,
              dividerThickness: 0,
              columns: const [
                DataColumn(label: Text('')),
                DataColumn(label: Text("")),
                DataColumn(label: Text("")),
                DataColumn(label: Text("")),
                DataColumn(label: Text("")),
                DataColumn(
                  label: Text(""),
                ),
                DataColumn(
                  label: Text(""),
                ),
              ],
              rows: [
                ...List.generate(
                  10,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                        Text(widget.orderId,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      DataCell(
                        Text(widget.customerName,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      DataCell(
                        Text(widget.customerEmail,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      DataCell(
                        Text('\$${widget.totalPrice}',
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      DataCell(OrderStatus(
                          status: widget.orderStatus, color: widget.color)),
                      DataCell(
                        Text(widget.orderDate,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      DataCell(
                        IconButton(
                          onPressed: widget.onPressed,
                          icon: Icon(
                            Icons.more_horiz,
                            color: AppColor.captionColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Row(
//               children: [
//                 Text(
//                   orderId,
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//                 const SizedBox(width: 20),
//                 Text(
//                   customerName,
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   customerEmail,
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//                 Text(
//                   '\$$totalPrice',
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//                 OrderStatus(
//                   status: orderStatus,
//                   color: color,
//                 ),
//                 Text(
//                   orderDate,
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//                 IconButton(
//                   onPressed: onPressed,
//                   icon: Icon(
//                     Icons.more_horiz,
//                     color: AppColor.captionColor.withOpacity(0.5),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    Key? key,
    required this.status,
    required this.color,
  }) : super(key: key);
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: color,
            ),
      ),
    );
  }
}
