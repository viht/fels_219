var count = document.querySelectorAll("[id=question]").length;
  window.onload=function(){
    window.setTimeout(function() {document.lessonform.submit();},
      count *20000);
  };

var timeleft = count*20;
  var downloadTimer = setInterval(function(){
    timeleft--;
    document.getElementById("countdowntimer").textContent = timeleft;
    if(timeleft <= 0)
      clearInterval(downloadTimer);
  },1000);
