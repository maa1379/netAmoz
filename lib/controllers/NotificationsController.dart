import 'package:ehyasalamat/helpers/PrefHelpers.dart';
import 'package:ehyasalamat/helpers/RequestHelper.dart';
import 'package:ehyasalamat/helpers/ViewHelpers.dart';
import 'package:ehyasalamat/models/InformsModel.dart';
import 'package:get/get.dart';




class NotificationsController extends GetxController{

  RxList<InformsModel> informsList = <InformsModel> [].obs;
  RxBool loading = false.obs;

  getNotifications({String role})async{
    RequestHelper.informs(role: role,token: await PrefHelpers.getToken()).then((value){
      if(value.isDone){
        for(var i in value.data){
          informsList.add(InformsModel.fromJson(i));
        }
        loading.value = true;
      }else{
        loading.value = false;
        ViewHelper.showErrorDialog(Get.context,"ارتباط برقرار نشد");
      }
    });
  }

}