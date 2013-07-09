dataAdapter = require('../mongoAdapter');

exports.getEventTimeAnalysisData = function(eventID,fn){
      dataAdapter.getDocuments({},"EventDetails_"+eventID,function(docs){
          if(docs.length==0){
              var result = new Object();
              fn(result['empty'] = 1);
              return;
          }
          var minimumTime = docs[0].timeStamp;
          var maxTime = docs[docs.length-1].timeStamp;
          var interval = getTimeInterval(minimumTime,maxTime)
          if(interval == 0){
              interval =10;
          }
          var result = analyseTimePercep(docs,minimumTime,interval);
          dataAdapter.getSingleDocument({eventID:eventID},"EventDetails",function(data){
               var perceptions = data.perceptionSchema.split(":");
                var sorted = sortPerceptions(result,perceptions)
                  for(var e in sorted){
                      for(var i=0;i< sorted[e].length;i++){
                          if(!sorted[e][i]){
                              sorted[e][i]=0;
                          }
                      }
                  }
                   if(data.colors){
                       var colors = data.colors.split(":");
                       sorted["colors"] =getColorString(sorted,perceptions,colors);
                  }
                  sorted["startTime"] = minimumTime;
                  sorted["endTime"] = maxTime;
                  sorted["interval"] = interval;
                 // console.log(sorted);
                  fn(sorted);
          });
      });
}

exports.getSelfTimeAnalysis = function(userID,eventID,fn){
    if(!eventID){
        var query = {};
    }else{
        var query = {eventID:eventID}
    }
    dataAdapter.getDocuments(query,"UserPerceptions_"+userID,function(docs){
        if(docs.length==0){
            var result = new Object();
            fn(result['empty'] = 1);
            return;
        }
        var minimumTime = docs[0].timeStamp;
        var maxTime = docs[docs.length-1].timeStamp;
        var interval = getTimeInterval(minimumTime,maxTime)
        if(interval == 0){
            interval =10;
        }
        var result = analyseTimePercep(docs,minimumTime,interval);
        if(eventID){
            dataAdapter.getSingleDocument({eventID:eventID},"EventDetails",function(data){
                var perceptions = data.perceptionSchema.split(":");
                var result = sortPerceptions(result,perceptions)
                for(var e in result){
                    for(var i=0;i< result[e].length;i++){
                        if(!result[e][i]){
                            result[e][i]=0;
                        }
                    }
                }
                if(data.colors){
                    var colors = data.colors.split(":");
                    result["colors"] =getColorString(result,perceptions,colors);
                }
                result["startTime"] = minimumTime;
                result["endTime"] = maxTime;
                result["interval"] = interval;
                // console.log(sorted);
                fn(result);
            });
        }else{
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
        }
    });
}
//define the sapling interval according to a fix number of samples
getTimeInterval = function(startTime,endTime){
    var duration = endTime - startTime;
    return Math.floor(duration/100);
}

//return the tome analysis data object for the given docs(data)
analyseTimePercep = function(docs,minTime,interval){
    var result = new Object();
    for(var i=0 ; i<docs.length ; i++){
        var index = Math.floor((docs[i].timeStamp-minTime)/(interval));
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
    return result
}
// given a perception count object this returns a object which is in order of the perceptionSchema
sortPerceptions = function(perceptionData,referenceData){
            sortedPerceps = new Object();
            for(var i=0; i<referenceData.length;i++){
                 if(!perceptionData[referenceData[i]]){
                     continue;
                 }
              sortedPerceps[referenceData[i]] = perceptionData[referenceData[i]];
             }
             perceptionData = sortedPerceps;
             return perceptionData;
}

//this returns a color string corresponding to given perceptionData and perception schema
getColorString = function(perceptionData, percepSchema,colorRef){
        if(Object.keys(perceptionData).length == colorRef.length){
           return colorRef;
        }
        var colors = new Array(); //an array  to store corresponding color values
        for(percep in perceptionData){
            var j=0
            for(var i=j;i<percepSchema.length;i++){
                if(percepSchema[i] != percep){
                    continue;
                }
                colors.push(colorRef[i]);
                j=i++;
            }
        }
    return colors
}