// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String logoUrl;
  final String imageUrl;
  final String description;
  final List<String> tags;
  final List<String> menuItemsId;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;
  final List<String> ratingsId;
  final String priceCategory;
  final Place location;
  final String addedAt;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.email,
    required this.logoUrl,
    required this.imageUrl,
    required this.tags,
    required this.menuItemsId,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.distance,
    required this.ratingsId,
    required this.priceCategory,
    required this.location,
    required this.addedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        phone,
        tags,
        menuItemsId,
        deliveryTime,
        deliveryFee,
        distance,
        priceCategory,
        ratingsId,
        logoUrl,
        description,
        addedAt,
        location,
        email,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'logoUrl': logoUrl,
      'imageUrl': imageUrl,
      'description': description,
      'tags': tags,
      'menuItemsId': menuItemsId,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'distance': distance,
      'ratingsId': ratingsId,
      'priceCategory': priceCategory,
      'location': location.toMap(),
      'addedAt': addedAt,
      'email': email,
    };
  }

  factory Restaurant.fromFirestore(DocumentSnapshot snap) {
    return Restaurant(
      id: snap.id,
      name: snap['name'],
      logoUrl: snap['logoUrl'],
      phone: snap['phone'],
      email: snap['email'],
      imageUrl: snap['imageUrl'],
      description: snap['description'],
      tags: List<String>.from((snap['tags'])),
      menuItemsId: List<String>.from((snap['menuItemsId'])),
      deliveryTime: snap['deliveryTime'],
      deliveryFee: snap['deliveryFee'].toDouble(),
      distance: snap['distance'].toDouble(),
      ratingsId: List<String>.from((snap['ratingsId'])),
      priceCategory: snap['priceCategory'],
      addedAt: snap['addedAt'],
      location: Place.fromMap(snap['location']),
    );
  }
}
