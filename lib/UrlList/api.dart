import 'package:miogra_seller/Constants/const_variables.dart';

class API {
  
   // static String microServiceUrl  =  "https://backend.miogra.com/";
      static String microServiceUrl  =  "https://dev.miogra.com/";

//registerapi
  static String register = '${microServiceUrl}api/user/subAdmin/register';

//loginapi
  static String login = '${microServiceUrl}api/user/subAdmin/login';

//getRegion
  static String getRegionApi = '${microServiceUrl}api/user/region';

//requestOtp
  static String requestOtp = '${microServiceUrl}api/user/email/requestOtp';

//verifyotp
  static String verifyotp = '${microServiceUrl}api/user/verifyOtp';

//newpassword
  static String newPasswordapi =
      "${microServiceUrl}api/user/subAdmin/forgotPassword";

//profileget
  static String profileGetApi = "${microServiceUrl}api/user/subAdmin";

//categoryListApi
  static String categoryListApi = "${microServiceUrl}api/food/foodCategory/";

//categorycreate
  static String categoryCreateApi = "${microServiceUrl}api/food/foodCategory";

//categoryUpdate
  static String categoryUpdateApi =
      "${microServiceUrl}api/food/foodCategory/update/";
       //FAQ 
  static String faq = '${microServiceUrl}api/sense/faq/listFetch';

//productCategory
  static String productCategoryapi =
      "${microServiceUrl}api/user/productCate?productType=restaurant";

//image upload
  static String bannerUpload =
      '${microServiceUrl}api/utility/file/foodImageUpload';

//hashtagcategory
  static String hashtagcatapi = '${microServiceUrl}api/utility/hashtag';

//getfoodlistPagenation
  static String getFoodlistPagenation = '${microServiceUrl}api/food/foodlist/';

//createfoodlist
  static String createFoodlist = '${microServiceUrl}api/food/foodlist?';

// getFoodlist
  static String getFoodlist = '${microServiceUrl}api/food/foodlist?';

//getfoodcuisineapi
  static String getFoodCuisine = '${microServiceUrl}api/food/foodcuisines';

//deleteFood
  static String deleteFood = '${microServiceUrl}api/food/foodlist/delete';

//foodUpdate
  static String updateFood = '${microServiceUrl}api/food/foodlist/update';

//neworders
  static String newOrdersGet = '${microServiceUrl}api/order/order?subAdminId=';

//orderStatus
  static String orderStatusApi = '${microServiceUrl}api/order/order/';

//neworders
  static String ordersApi =
      '${microServiceUrl}api/order/order/orderGetPagination?';

//insightOrders
  static String insightOrders =
      '${microServiceUrl}api/order/dashboard/getSubAdminDashboard?';

//chartsApi
  static String chartsApi =
      '${microServiceUrl}api/order/income/getIncome?subAdminId=';

//activeStatusApi
  static String activeStatusApi = '${microServiceUrl}api/user/subAdmin/update';


  //individualstatus
  
static String individualstatus = "${microServiceUrl}api/user/subAdmin/update/individualStatus";

static String singleResStatusUpdate ="${microServiceUrl}api/sense/foodMigrate/singleResStatusUpdate";

 static String imageuploadurl =
     '${microServiceUrl}api/utility/file/bannerUpload';

  static String appConfigUrl = '${microServiceUrl}api/utility/appConfig';

  //Order Fetch continous in homescreen
  static String orderfetch =
      "${microServiceUrl}api/order/order/fetchNewOrderAdmin/accept";

// static String baseUrl= 'http://ec2-3-110-51-78.ap-south-1.compute.amazonaws.com:8000/';
// //  static String baseUrl = 'https://www.thefastx.com/';

// //registerapi
// static String register='${baseUrl}api/subAdmin/register';

// //loginapi
// static String login='${baseUrl}api/subAdmin/login';

// //getRegion
// static String getRegionApi='${baseUrl}api/region';

// //requestOtp
// static String requestOtp='${baseUrl}api/email/requestOtp';

// //verifyotp
// static String verifyotp='${baseUrl}api/verifyOtp';

// //newpassword
// static String newPasswordapi="${baseUrl}api/subAdmin/forgotPassword";

// //profileget
// static String profileGetApi="${baseUrl}api/subAdmin";

// //categoryListApi
// static String categoryListApi="${baseUrl}api/foodCategory/";

// //categorycreate
// static String categoryCreateApi="${baseUrl}api/foodCategory";

// //categoryUpdate
// static String categoryUpdateApi="${baseUrl}api/foodCategory/update/";

// //productCategory
// static String productCategoryapi="${baseUrl}api/productCate?productType=restaurant";

// //image upload
// static String bannerUpload = '${baseUrl}api/file/bannerUpload';

// //hashtagcategory
// static String hashtagcatapi='${baseUrl}api/hashtag';

// //getfoodlistPagenation
// static String getFoodlistPagenation='${baseUrl}api/foodlist/';

// //createfoodlist
// static String createFoodlist='${baseUrl}api/foodlist?';

// // getFoodlist
// static String getFoodlist='${baseUrl}api/foodlist?';

// //getfoodcuisineapi
// static String getFoodCuisine='${baseUrl}api/foodcuisines';

// //deleteFood
// static String deleteFood='${baseUrl}api/foodlist/delete';

// //foodUpdate
// static String updateFood='${baseUrl}api/foodlist/update';

// //neworders
// static String newOrdersGet='${baseUrl}api/order?subAdminId=';

// //orderStatus
// static String orderStatusApi='${baseUrl}api/order/';

// //neworders
// static String ordersApi='${baseUrl}api/order/orderGetPagination?';

// //insightOrders
// static String insightOrders='${baseUrl}api/dashboard/getSubAdminDashboard?';

// //chartsApi
// static String chartsApi='${baseUrl}api/income/getIncome?subAdminId=';

// //activeStatusApi
// static String activeStatusApi='${baseUrl}api/subAdmin/update';

// static String imageuploadurl= '${baseUrl}api/file/bannerUpload';

//  static String appConfigUrl= '${baseUrl}api/appConfig';

  //header
  Map<String, String> headers = {
    "Accept": "/",
    "Content-Type": "application/json",
    "userid": "$userId",
    "Authorization": "Bearer $usertoken"
  };

  Map<String, String> headersWithoutToken = {
    "Accept": "/",
    "Content-Type": "application/json",
  };
}
