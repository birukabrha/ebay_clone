import 'package:flutter/material.dart';

class Product {
  final String name;
  final String conditionDesc;
  final double rating;
  final double price;
  final double? discounRate;
  final double itemsInStock;
  final double itemsSold;
  final double? itemsRemaining;
  final String condition;
  final bool sellerWarranty;
  final String model;
  final String itemdesc;
  final String brandName;
  final String category;

  Product(
      this.name,
      this.conditionDesc,
      this.rating,
      this.price,
      this.discounRate,
      this.itemsInStock,
      this.itemsSold,
      this.itemsRemaining,
      this.condition,
      this.sellerWarranty,
      this.model,
      this.itemdesc,
      this.brandName,
      this.category);
}
