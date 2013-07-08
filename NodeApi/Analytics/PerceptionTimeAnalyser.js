dataAdapter = require('../mongoAdapter');

exports.getTimeAnalysisData = function(collection,sortKey,fn){
    var result = new Object();
      dataAdapter.getDocuments({},collection,function(docs){
          if(docs.length==0){
              fn(result['empty'] = 1);
              return;
          }
          var minimumTime = docs[0].timeStamp;
          var maxTime = docs[docs.length-1].timeStamp;
          var interval = getTimeInterval(minimumTime,maxTime)
          if(interval == 0){
              interval =10;
          }
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

         // console.log(result);
          var id = collection.split("_")[1];
          console.log(id);
          dataAdapter.getSingleDocument({eventID:id},"EventDetails",function(data){
               var perceptions = data.perceptionSchema.split(":");

              //console.log(colors);
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

//define the sapling interval according to a fix number of samples
getTimeInterval = function(startTime,endTime){
    var duration = endTime - startTime;
    return Math.floor(duration/100);
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