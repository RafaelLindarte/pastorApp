
class NotificationState {



  String _type = '';
  String _status = '';


  set setStatus(String status){
    _status = status;
  }
  set setType(String type){
    _type = type;
  }


  get status => _status;
  get type =>  _type;
}