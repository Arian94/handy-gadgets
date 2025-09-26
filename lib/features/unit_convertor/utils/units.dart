abstract class UnitsAndFactors {
  Map<String, dynamic> makeUnitsAndFactors();
}

class TimeUnits implements UnitsAndFactors {
  static const second = 'Second';
  static const millisecond = 'Millisecond';
  static const microsecond = 'Microsecond';
  static const nanosecond = 'Nanosecond';
  static const minute = 'Minute';
  static const hour = 'Hour';
  static const day = 'Day';
  static const week = 'Week';
  static const month = 'Month';
  static const year = 'Year';
  static const decade = 'Decade';
  static const century = 'Century';
  static const millennium = 'Millennium';

  @override
  Map<String, dynamic> makeUnitsAndFactors() {
    final units = [
      second,
      millisecond,
      microsecond,
      nanosecond,
      minute,
      hour,
      day,
      week,
      month,
      year,
      decade,
      century,
      millennium,
    ];
    final unitToFactors = {
      second: 1.0,
      millisecond: 0.001,
      microsecond: 1e-6,
      nanosecond: 1e-9,
      minute: 60.0,
      hour: 3600.0,
      day: 86400.0,
      week: 604800.0,
      month: 2.629746e6, // average month
      year: 3.1556926e7, // average year
      decade: 3.1556926e8,
      century: 3.1556926e9,
      millennium: 3.1556926e10,
    };

    return {'units': units, 'unitToFactors': unitToFactors};
  }
}

class LengthUnits implements UnitsAndFactors {
  static const meter = 'Meter';
  static const kilometer = 'Kilometer';
  static const centimeter = 'Centimeter';
  static const millimeter = 'Millimeter';
  static const micrometer = 'Micrometer';
  static const nanometer = 'Nanometer';
  static const mile = 'Mile';
  static const yard = 'Yard';
  static const foot = 'Foot';
  static const inch = 'Inch';
  static const nauticalMile = 'Nautical Mile';
  static const lightYear = 'Light Year';
  static const parsec = 'Parsec';
  static const angstrom = 'Angstrom';
  static const furlong = 'Furlong';
  static const chain = 'Chain';
  static const rod = 'Rod';
  static const league = 'League';
  static const astronomicalUnit = 'Astronomical Unit';
  static const planckLength = 'Planck Length';

  @override
  Map<String, dynamic> makeUnitsAndFactors() {
    final units = [
      meter,
      kilometer,
      centimeter,
      millimeter,
      micrometer,
      nanometer,
      mile,
      yard,
      foot,
      inch,
      nauticalMile,
      lightYear,
      parsec,
      angstrom,
      furlong,
      chain,
      rod,
      league,
      astronomicalUnit,
      planckLength,
    ];
    final unitToFactors = {
      LengthUnits.meter: 1.0,
      LengthUnits.kilometer: 1000.0,
      LengthUnits.centimeter: 0.01,
      LengthUnits.millimeter: 0.001,
      LengthUnits.micrometer: 1e-6,
      LengthUnits.nanometer: 1e-9,
      LengthUnits.mile: 1609.344,
      LengthUnits.yard: 0.9144,
      LengthUnits.foot: 0.3048,
      LengthUnits.inch: 0.0254,
      LengthUnits.nauticalMile: 1852.0,
      LengthUnits.lightYear: 9.4607e15,
      LengthUnits.parsec: 3.0857e16,
      LengthUnits.angstrom: 1e-10,
      LengthUnits.furlong: 201.168,
      LengthUnits.chain: 20.1168,
      LengthUnits.rod: 5.0292,
      LengthUnits.league: 4828.032,
      LengthUnits.astronomicalUnit: 1.495978707e11,
      LengthUnits.planckLength: 1.616255e-35,
    };

    return {'units': units, 'unitToFactors': unitToFactors};
  }
}

class WeightUnits implements UnitsAndFactors {
  static const kilogram = 'Kilogram';
  static const gram = 'Gram';
  static const milligram = 'Milligram';
  static const microgram = 'Microgram';
  static const ton = 'Ton';
  static const metricTon = 'Metric Ton';
  static const pound = 'Pound';
  static const ounce = 'Ounce';
  static const stone = 'Stone';
  static const carat = 'Carat';
  static const atomicMassUnit = 'Atomic Mass Unit';
  static const quintal = 'Quintal';
  static const dram = 'Dram';
  static const grain = 'Grain';
  static const longTon = 'Long Ton';
  static const shortTon = 'Short Ton';
  static const slug = 'Slug';
  static const solarMass = 'Solar Mass';
  static const planckMass = 'Planck Mass';
  static const troyOunce = 'Troy Ounce';

  @override
  Map<String, dynamic> makeUnitsAndFactors() {
    final units = [
      kilogram,
      gram,
      milligram,
      microgram,
      ton,
      metricTon,
      pound,
      ounce,
      stone,
      carat,
      atomicMassUnit,
      quintal,
      dram,
      grain,
      longTon,
      shortTon,
      slug,
      solarMass,
      planckMass,
      troyOunce,
    ];
    final unitToFactors = {
      kilogram: 1.0,
      gram: 0.001,
      milligram: 1e-6,
      microgram: 1e-9,
      ton: 1000.0,
      metricTon: 1000.0,
      pound: 0.45359237,
      ounce: 0.0283495231,
      stone: 6.35029318,
      carat: 0.0002,
      atomicMassUnit: 1.66053906660e-27,
      quintal: 100.0,
      dram: 0.0017718452,
      grain: 0.00006479891,
      longTon: 1016.0469088,
      shortTon: 907.18474,
      slug: 14.593903,
      solarMass: 1.98847e30,
      planckMass: 2.176434e-8,
      troyOunce: 0.0311034768,
    };

    return {'units': units, 'unitToFactors': unitToFactors};
  }
}
