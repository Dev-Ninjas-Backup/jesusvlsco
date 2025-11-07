/// LIST OF Enums
/// They cannot be created inside a class.
library;

enum TextSizes { small, medium, large }

enum OrderStatus { processing, shipped, delivered }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm,
}

// Resend method enum
enum ResendMethod { whatsapp, sms, call, email }
