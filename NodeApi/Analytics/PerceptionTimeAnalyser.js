/**
 * @author Sachintha
 */
dataAdapter = require('../mongoAdapter');

exports.getTimeAnalysisData = function(collection,sortKey,fn){
    var result = new Object();
      dataAdapter.getSortedDocuments({},collection,sortKey,function(docs){
          var timediff = docs[docs.length-1].timeStamp-docs[0].timeStamp;
          var minimumTime = docs[0].timeStamp;
          for(var i=0;i<docs.length;i++){
             var index = Math.floor((docs[i].timeStamp-minimumTime)/(500000));
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
          result["startTime"] = docs[0].timeStamp;
          result["endTime"] = docs[docs.length-1].timeStamp;
            fn(result);
          //console.log(result);
          //console.log(result["Wonderful"][1]) ;
      });
}