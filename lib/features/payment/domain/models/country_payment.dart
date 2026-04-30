enum PaymentMethodType { cash, creditCard }

class CountryPayment {
  final String code;
  final String nameEn;
  final String nameAr;
  final String flag;
  final List<PaymentMethodType> methods;

  const CountryPayment({
    required this.code,
    required this.nameEn,
    required this.nameAr,
    required this.flag,
    required this.methods,
  });

  String localName(String langCode) =>
      langCode == 'ar' ? nameAr : nameEn;
}

const List<CountryPayment> supportedCountries = [
  CountryPayment(
    code: 'SA', nameEn: 'Saudi Arabia', nameAr: 'السعودية', flag: '🇸🇦',
    methods: [PaymentMethodType.cash, PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'AE', nameEn: 'United Arab Emirates', nameAr: 'الإمارات', flag: '🇦🇪',
    methods: [PaymentMethodType.cash, PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'KW', nameEn: 'Kuwait', nameAr: 'الكويت', flag: '🇰🇼',
    methods: [PaymentMethodType.cash, PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'QA', nameEn: 'Qatar', nameAr: 'قطر', flag: '🇶🇦',
    methods: [PaymentMethodType.cash, PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'EG', nameEn: 'Egypt', nameAr: 'مصر', flag: '🇪🇬',
    methods: [PaymentMethodType.cash, PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'JO', nameEn: 'Jordan', nameAr: 'الأردن', flag: '🇯🇴',
    methods: [PaymentMethodType.cash, PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'US', nameEn: 'United States', nameAr: 'الولايات المتحدة', flag: '🇺🇸',
    methods: [PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'GB', nameEn: 'United Kingdom', nameAr: 'المملكة المتحدة', flag: '🇬🇧',
    methods: [PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'DE', nameEn: 'Germany', nameAr: 'ألمانيا', flag: '🇩🇪',
    methods: [PaymentMethodType.creditCard],
  ),
  CountryPayment(
    code: 'FR', nameEn: 'France', nameAr: 'فرنسا', flag: '🇫🇷',
    methods: [PaymentMethodType.creditCard],
  ),
];
