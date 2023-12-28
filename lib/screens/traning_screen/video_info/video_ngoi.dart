
import 'package:flutter/material.dart';
import 'package:app_pet_shop/constants/colors.dart' as color;
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import '../traning_screen.dart';
class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoinfo = [];
  bool _playArea = false;
  bool _isplaying = false;
  bool _disposed = false;
  int _isPlayingIndex =-1;
   VideoPlayerController? _controller;
  _initDatat() async{
   await DefaultAssetBundle.of(context).loadString("assets/json/video_ngoi.json").then((value) =>{
    setState((){
      videoinfo = json.decode(value);
    })
    });
  }
  @override
  void initState(){
    super.initState();
    _initDatat();
  }
  @override
  void dispose(){
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller= null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea==false?BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.AppColors.gradientFirst.withOpacity(0.9),
              color.AppColors.gradientSecond,
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          )
        ):BoxDecoration(
          color: color.AppColors.gradientSecond
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _playArea==false?Container(
              padding: const EdgeInsets.only(top: 70,left: 30,right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (context) => TraningScreen(),
                          ),
                        ),
                        child: const Icon(Icons.arrow_back_ios,color:Colors.white),
                      ),
                      Expanded(child: Container()),
                      Icon(Icons.info_outline,size: 20,
                        color: color.AppColors.secondPageIconColor,),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text("Hữu ích",
                    style: TextStyle(
                      fontSize: 25,
                      color: color.AppColors.secondPageTitleColor,

                    ),),
                  SizedBox(height: 5,),
                  Text("Và vô cùng sinh dộng ",
                    style: TextStyle(
                      fontSize: 25,
                      color: color.AppColors.secondPageTitleColor,
                    ),),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              color.AppColors.secondPageContainerGradient1stColor,
                              color.AppColors.secondPageContainerGradient2stColor,

                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer,
                            size: 20,
                            color: color.AppColors.secondPageIconColor,),
                            SizedBox(width: 5,),
                            Text("3 Phút",
                            style: TextStyle(
                              fontSize: 16,
                              color:color.AppColors.secondPageTitleColor,


                            ),)
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Container(
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                color.AppColors.secondPageContainerGradient1stColor,
                                color.AppColors.secondPageContainerGradient2stColor,

                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.handyman_outlined,
                              size: 20,
                              color: color.AppColors.secondPageIconColor,),
                            SizedBox(width: 5,),
                            Text("Cùng nhau rèn luyện",
                              style: TextStyle(
                                fontSize: 16,
                                color:color.AppColors.secondPageTitleColor,


                              ),)
                          ],
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ):Container(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 50,left: 30,right: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (context) => TraningScreen(),
                                ),
                              ),
                              child: const Icon(Icons.arrow_back_ios,color:Colors.white),
                            ),
                            Expanded(child: Container()),
                            Icon(Icons.info_outline,
                            size: 20,
                              color: color.AppColors.secondPageIconColor,)
                          ],
                        ),
                      ),
                      _playView(context),
                      _controlView(context),
                    ],
                  ),
            ) ,
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(70),

                )
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      SizedBox(width: 30,),
                      Text("Tất cả Bài tập cho thú cưng!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color.AppColors.circuitsColor
                      ),),
                      Expanded(child:Container()),
                      Row(
                        children: [
                          Icon(Icons.loop,size: 30,
                          color: color.AppColors.loopColor,),
                          SizedBox(width: 10,),
                          Text("8 video",
                          style: TextStyle(
                            fontSize: 15,
                            color: color.AppColors.setsColor,
                          ),)
                        ],
                      ),
                      SizedBox(width: 20,),

                    ],
                  ),
                  SizedBox(height: 12,),
                  Expanded(child: _listView())
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
 Widget _controlView(BuildContext context){
    final noMute = (_controller?.value?.volume??0)>0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: color.AppColors.gradientSecond,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              InkWell(
                onTap: (){
                    if(noMute){
                      _controller?.setVolume(0);
                    }else{
                      _controller?.setVolume(1.0);
                    }
                    setState(() {

                    });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0,0.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(50, 0, 0, 0),
                        )
                      ]
                    ),
                    child: Icon(
                     noMute?Icons.volume_down:Icons.volume_off,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: (){
                  final index = _isPlayingIndex-1;
                  if(index>=0&&videoinfo.length>=0){
                    _initializeVideo(index);
                  }else{
                    Get.snackbar("Danh sách video","",
                    snackPosition: SnackPosition.BOTTOM,
                    icon: Icon(Icons.face,
                    size: 30,
                    color: Colors.white,),
                      backgroundColor: color.AppColors.gradientSecond,
                      colorText:Colors.white,
                      messageText: Text(
                        "Đây là video đầu tiên",
                        style: TextStyle(
                          fontSize: 20,
                          color:Colors.white,
                        ),
                      )

                    );
                  }
                },
                child: Icon(Icons.fast_rewind
                ,size: 36,
                color: Colors.white,),

              ),
              TextButton(
                onPressed: (){
                  if(_isplaying){
                    setState(() {
                      _isplaying =false;
                    });
                    _controller?.pause();
                  }else{
                    setState(() {
                      _isplaying =true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(_isplaying?Icons.pause:   Icons.play_arrow
                  ,size: 36,
                  color: Colors.white,),

              ),
              TextButton(
                onPressed: (){
                    final index = _isPlayingIndex+1;
                    if(index <= videoinfo.length-1){
                      _initializeVideo(index);
                    }else{
                      Get.snackbar("Danh sách video","",
                          snackPosition: SnackPosition.BOTTOM,
                          icon: Icon(Icons.face,
                            size: 30,
                            color: Colors.white,),
                          backgroundColor: color.AppColors.gradientSecond,
                          colorText:Colors.white,
                          messageText: Text(
                            "Đây là video cuối cùng! cám ơn bạn đã theo dõi",
                            style: TextStyle(
                              fontSize: 20,
                              color:Colors.white,
                            ),
                          )

                      );
                    }

                },
                child: Icon(Icons.fast_forward
                  ,size: 36,
                  color: Colors.white,),

              )
            ],
          ),
        ),
      ],
    );

  }
  Widget _playView(BuildContext context){
        final controller = _controller;
        if(controller!= null &&controller.value.isInitialized ){
          return AspectRatio(
              aspectRatio: 16/9,
            child: VideoPlayer(controller),
          );
        }else{
          return AspectRatio(
            aspectRatio: 16/9,
              child: Center(child: Text("Đợi trong giây lát.....")));
        }
  }
  _onTapVideo(int index){
    _initializeVideo(index);
  }
  var _onUpdateControllerTime;
  void _onControllerUpdate()async{
    if(_disposed){
      return;
    }
    _onUpdateControllerTime =0;

    final now = DateTime.now().microsecondsSinceEpoch;
    if(_onUpdateControllerTime>now){
      return;
    }

    _onUpdateControllerTime = now+500;
      final controller= _controller;
      if(controller == null){
        debugPrint("Trống");
        return;
      }
      if(!controller.value.isInitialized){
        debugPrint("controller can not be initializes");
        return;
      }
      final playing = controller.value.isPlaying;
      _isplaying = playing;
  }
  _initializeVideo(int index)async{
      final controller = VideoPlayerController.asset(videoinfo[index]["videoUrl"]);
      final old =_controller;
      _controller = controller;
      if(old!= null){
        old.removeListener(_onControllerUpdate);
        old.pause();
      }
      setState(() {

      });
      controller..initialize().then((_){
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {

        });

      });
  }
  _listView(){
    return ListView.builder(
        padding:EdgeInsets.symmetric(horizontal: 30,vertical:8 ),
        itemCount: videoinfo.length,
        itemBuilder: (_,int index){
          return GestureDetector(
              onTap: (){
                _onTapVideo(index);
                debugPrint(index.toString());
                setState(() {
                  if(_playArea == false){
                    _playArea = true;
                  }
                });
              },
              child: _buildCard(index)
          );
        });

  }
  _buildCard(int index){
    return  Container(
      height: 135,
      //   color:Colors.redAccent,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        videoinfo[index]["img"],
                      ),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoinfo[index]["title"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height:10 ,),
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Text(
                      videoinfo[index]["time"],
                      style: TextStyle(
                          color: Colors.grey[500]
                      ),

                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Color(0xFFeaeefc),
                ),
                child: Text(
                  "1 phút nghỉ",
                  style: TextStyle(
                    color: Color(0xff839fed),

                  ),
                ),
              ),
              Row(
                children: [
                  for(int i =0;i<70;i++)
                    i.isEven?Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                        color: Color(0xff839fed),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ):Container(
                      width: 3,
                      height: 1,
                      color: Colors.white,
                    )

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
