import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderShimmer extends StatefulWidget {
  const OrderShimmer({super.key});

  @override
  State<OrderShimmer> createState() => _OrderShimmerState();
}

class _OrderShimmerState extends State<OrderShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [             
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height /10,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 10,
                color: Colors.grey,
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 10,
                color: Colors.grey,
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 10,
                color: Colors.grey,
              ),
              SizedBox(height: 25),
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 10,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}