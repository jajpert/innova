import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  String _cardNumber = '';
  String _cardHolder = '';
  String _expiryDate = '';
  String _cvv = '';

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_updateCardNumber);
    _cardHolderController.addListener(_updateCardHolder);
    _expiryDateController.addListener(_updateExpiryDate);
    _cvvController.addListener(_updateCVV);
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _updateCardNumber() {
    setState(() {
      _cardNumber = _cardNumberController.text;
    });
  }

  void _updateCardHolder() {
    setState(() {
      _cardHolder = _cardHolderController.text;
    });
  }

  void _updateExpiryDate() {
    setState(() {
      _expiryDate = _expiryDateController.text;
    });
  }

  void _updateCVV() {
    setState(() {
      _cvv = _cvvController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamento"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardPreview(),
              const SizedBox(height: 32),
              _buildTextField(
                controller: _cardHolderController,
                label: "Nome no Cartão",
                icon: Icons.person,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
                  LengthLimitingTextInputFormatter(24)
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _expiryDateController,
                label: "Data de Validade (MM/AA)",
                icon: Icons.calendar_today,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,2}/?\d{0,2}$')),
                  _ExpiryDateFormatter(),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _cvvController,
                label: "CVV",
                icon: Icons.lock,
                obscureText: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _cardNumberController,
                label: "Número do Cartão",
                icon: Icons.credit_card,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(
                      19), // 16 números + 3 espaços
                  _CardNumberFormatter(),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implementar ação de finalização do pagamento
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5D72F6),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Finalizar Pagamento",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.indigo[400],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.credit_card, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            _cardNumber.isNotEmpty ? _cardNumber : 'XXXX XXXX XXXX XXXX',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _cardHolder.isNotEmpty ? _cardHolder : 'Nome no Cartão',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                _expiryDate.isNotEmpty ? _expiryDate : 'MM/AA',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              _cvv.isNotEmpty ? _cvv : 'CVV',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black54),
            border: const UnderlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

/// Formata MM/AA para o campo de data de validade
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 2) {
      text = text.substring(0, 2) + '/' + text.substring(2);
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// Formata números de cartão no formato XXXX XXXX XXXX XXXX
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove todos os caracteres não numéricos
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita o número de dígitos a 16
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    // Formata os números em grupos de 4
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) {
        buffer.write(' ');
      }
    }

    // Atualiza o valor formatado e posiciona o cursor no final
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
