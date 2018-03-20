function BaiduMap(container_id, options){
  if($("#" + container_id).size() == 0){
    console.debug("baidu container " + container_id + " not found.");
    return;
  }
  console.debug("building baidu map, container is " + container_id);
  if(typeof(options) == "undefined") options = {};
  var center_point = options['center_point'];
  var zoom = options['zoom'] || 12;
  var pickLatLngHandler = function(point){};
  var onLoadHandler = function(map){};
  // 百度地图API功能
  var map = new BMap.Map(container_id); 
  map.centerAndZoom(center_point || "北京", zoom); // 必须加入这行，否则会出现JS错误 TypeError: undefined is not an object (evaluating 'a.KP.Ft')
  var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
  var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
  function centerToMyCity(result){
    var cityName = result.name;
    map.centerAndZoom(cityName, 12);
  }
  function setPlace(value){
    map.clearOverlays();    //清除地图上所有覆盖物
    function myFun(){
      var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
      map.centerAndZoom(pp, 18);
      map.addOverlay(new BMap.Marker(pp));    //添加标注
      pickLatLngHandler(pp);
    }
    var local = new BMap.LocalSearch(map, { //智能搜索
      onSearchComplete: myFun
    });
    local.search(value);
  }
  function pickLatLng(handler){
    pickLatLngHandler = handler;
    map.addEventListener("click", function(e){
      if(pickLatLngHandler){
        pickLatLngHandler(e.point);
      }else{
        alert(point.lng + "," + point.lat);
      }
    });
  }
  function onLoad(handler){
    onLoadHandler = handler;
  }
  function bindAutocomplete(input, handler){
    var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
      {"input" : input
      ,"location" : map
    });
    ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
      var _value = e.item.value;
      var myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
      handler(myValue);
    });
  }
  map.addControl(top_left_control); 
  map.addControl(top_left_navigation);
  // 有IP决定当前城市
  if(center_point == null){
    var myCity = new BMap.LocalCity();
    myCity.get(centerToMyCity);
  }
  console.debug("baidu map loaded");
  return {
    map: map,
    pickLatLng: pickLatLng,
    onLoad: onLoad,
    setPlace: setPlace,
    bindAutocomplete: bindAutocomplete
  }
}