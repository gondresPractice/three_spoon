import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tiga_sendok_app/data/model/create_customer_response.dart';
import 'package:tiga_sendok_app/data/model/customer_response.dart';
import 'package:tiga_sendok_app/data/model/login_response.dart';
import 'package:tiga_sendok_app/data/model/order_product_response.dart';
import 'package:tiga_sendok_app/data/model/register_response.dart';

import '../model/order_response.dart';
import '../model/product_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("register")
  @FormUrlEncoded()
  Future<RegisterResponse> registerUser(@Field("name") String name,
      @Field("email") String email, @Field("password") String password);

  @POST("login")
  @FormUrlEncoded()
  Future<LoginResponse> loginUser(
      @Field("email") String email, @Field("password") String password);

  @GET("customers")
  Future<CustomerResponse> getListCustomer();

  @POST("customers")
  @FormUrlEncoded()
  Future<CreateCustomerResponse> createNewCustomer(@Field("name") String name,
      @Field("gender") String gender, @Field("phone") int phone);

  @PUT("customers/{id}")
  @FormUrlEncoded()
  Future<CreateCustomerResponse> updateCustomer(
      @Path("id") int id,
      @Field("name") String name,
      @Field("gender") String gender,
      @Field("phone") int phone);
  @GET("products")
  Future<ProductResponse> getListProduct();

  @GET("orders")
  Future<OrderResponse> getListOrder();

  @POST("orders")
  @FormUrlEncoded()
  Future<OrderProductResponse> createNewOrder(
      @Field("customer_id") int customerId,
      @Field("product_id") int productId,
      @Field("qty") int quantity,
      @Field("price") int price);

  @PUT("orders/{id}")
  @FormUrlEncoded()
  Future<OrderProductResponse> updateOrder(
      @Path("id") int orderId,
      @Field("customer_id") int customerId,
      @Field("product_id") int productId,
      @Field("qty") int quantity,
      @Field("price") int price);
  @PUT("orders/{id}/pay")
  Future<OrderProductResponse> changeStatusPay(@Path('id') int orderId);

  @DELETE("customers/{id}")
  Future<void> deleteCustomer(@Path("id") int id);

  @DELETE("ordres/{id}")
  Future<void> deleteOrder(@Path("id") int id);
}
