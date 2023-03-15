import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../data/Provider/shopping_cart.dart';
import 'package:intl/intl.dart';


class ShoppPage extends StatefulWidget {
  const ShoppPage({Key? key}) : super(key: key);

  @override
  State<ShoppPage> createState() => _ShoppPageState();
}

class _ShoppPageState extends State<ShoppPage> {
  @override
  Widget build(BuildContext context) {

    final Cart cart = Provider.of<Cart>(context);
    final _formKey = GlobalKey<FormBuilderState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Verificar',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFAFAFA),
            ),
          ),
          elevation: 0,
          bottom: TabBar(
            labelColor: Color(0xFFFAFAFA),
            indicatorColor: Color(0xFF8C8C8C),
            tabs: [
              Tab(text: 'Productos'),
              Tab(text: 'Pago'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Primera pestaña
            Column(
              children: [
                SizedBox(height: 16),
                Text('Total de Productos: ${cart.itemCount}'),
                SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFD2D2D2),
                          width: 1,
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final item = cart.items.values.toList()[index];
                          final quantity = cart.getSelectedQuantity(item.id);
                          return Column(
                            children: [
                              ListTile(
                                title: Text(item.title),
                                subtitle: Text(
                                    'Precio: \$${item.price}, Cantidad: ${item.quantity}'),
                                trailing:
                                Text('Total: \$${item.price * item.quantity}'),
                              ),
                              Divider(
                                color: Color(0xFFD2D2D2),
                                thickness: 1,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Total a pagar: \$${cart.totalAmount}'),
                SizedBox(height: 16),
              ],
            ),
            // Segunda pestaña
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormBuilder(
                          key: _formKey,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFD2D2D2),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  FormBuilderTextField(
                                    name: 'nombre',
                                    decoration: InputDecoration(labelText: 'Nombre'),
                                    validator: FormBuilderValidators.required(context),

                                  ),
                                  FormBuilderTextField(
                                    name: 'tarjeta',
                                    decoration: InputDecoration(labelText: 'Número de tarjeta'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.creditCard(context),
                                    ]),
                                  ),
                                  FormBuilderDateTimePicker(
                                    name: 'expiracion',
                                    inputType: InputType.date,
                                    format: DateFormat('MM/yy'),
                                    decoration: InputDecoration(labelText: 'Fecha de expiración'),
                                    validator: FormBuilderValidators.required(context),
                                  ),
                                  FormBuilderTextField(
                                    name: 'cvc',
                                    decoration: InputDecoration(labelText: 'CVC'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.minLength(context, 3),
                                      FormBuilderValidators.maxLength(context, 4),
                                    ]),
                                  ),
                                  FormBuilderTextField(
                                    name: 'monto',
                                    decoration: InputDecoration(labelText: 'Monto a pagar'),
                                    validator: FormBuilderValidators.required(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            // Enviar los datos de pago a Stripe
                            //_handlePayment();
                          }
                        },
                        color: Color(0xFF33C283),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minWidth: double.infinity,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              40, 20, 40, 20),
                          child: Text(
                            "Comprar",
                            style: TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
