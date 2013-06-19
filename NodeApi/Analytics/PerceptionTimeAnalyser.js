dataAdapter = require('../mongoAdapter');

exports.getTimeAnalysisData = function(collection,sortKey,fn){
    var result = new Object();
      dataAdapter.getDocuments({},collection,function(docs){
          var minimumTime = docs[0].timeStamp;
          var maxTime = docs[docs.length-1].timeStamp;
          var interval = getTimeInterval(minimumTime,maxTime)
          for(var i=0 ; i<docs.length ; i++){
             var index = Math.floor((docs[i].timeStamp-minimumTime)/(interval));
              var perception = docs[i].perceptionValue;
              if(result[perception]){
                  if(result[perception][index]){
                      ++result[perception][index];
                  }else{
                      result[perception][index] = 1;
                  }
              }else{
                  result[perception] = new Array();
                  result[perception][index] = 1;
              }
          }

          console.log(result);
          for(var e in result){
              for(var i=0;i< result[e].length;i++){
                  if(!result[e][i]){
                      result[e][i]=0;
                  }
              }
          }
          result["startTime"] = minimumTime;
          result["endTime"] = maxTime;
          result["interval"] = interval;
            fn(result);
          //console.log(result);
          //console.log(result["Wonderful"][1]) ;
      });
}

getTimeInterval = function(startTime,endTime){
    var duration = endTime - startTime;
    return Math.floor(duration/100);
}