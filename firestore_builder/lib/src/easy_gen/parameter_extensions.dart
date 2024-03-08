import 'package:code_builder/code_builder.dart';

extension ParameterExtensions on Parameter {
  Parameter get toThisParameter {
    return rebuild(
      (parameterBuilder) => parameterBuilder
        ..toThis = true
        ..type = null,
    );
  }
}

sealed class Vehicle {
  const Vehicle({required this.wheels});

  final int wheels;
}

class Bicycle extends Vehicle {
  const Bicycle({
    required super.wheels,
    required this.color,
  });

  final String color;
}

class Car extends Vehicle {
  const Car({
    required this.color,
  }) : super(wheels: 4);
  final String color;
}

class Truck implements Vehicle {
  const Truck({
    required this.wheels,
    required this.color,
  });

  @override
  final int wheels;
  final String color;
}

Vehicle myCar = const Car(color: 'red');

String getVehicleSound(Vehicle vehicle) {
  final wheels = vehicle.wheels;
  return switch (vehicle) {
    Car() => 'vroom',
    Truck() => 'VROOOOMM',
    Bicycle() => 'ring ring',
  };
}
