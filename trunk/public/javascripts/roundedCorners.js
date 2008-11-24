
/* This script and many more are available free online at
The JavaScript Source :: http://javascript.internet.com
Created by: Vic Phillips :: http://www.vicsjavascripts.org.uk */

// The math and aliase techniques learnt from a script by
// Cameron Cooke and Tim Hutchison - http://www.curvycorners.net

function zxcCorners(){
 var zxcdivs=document.getElementsByTagName('BODY')[0].getElementsByTagName('DIV');
 var zxcary=[];
 for (var zxc0=0;zxc0<zxcdivs.length;zxc0++){
 if (zxcdivs[zxc0].className.match('zxc')){ zxcary.push(zxcdivs[zxc0]); }
 }
 for (var zxc1=0;zxc1<zxcary.length;zxc1++){
 zxcCornersMake(zxcary[zxc1]);
 }
}

function zxcCornersMake(zxcobj){
 var zxcstyle=zxcStyleAry(zxcobj);
 zxcOptions(zxcobj);
 var zxcopts=zxcOptions(zxcobj);
 var zxcrary=[zxcopts[0]*1];
 if (zxcopts[1]&&zxcopts[2]){ zxcrary.push(zxcopts[0]+zxcopts[1]); }
 else if (zxcstyle[5]){
 if (zxcstyle[5].match('#')){ zxcrary.push(zxcopts[0]+parseInt(zxcstyle[5].split(' ')[1])); zxcopts[2]='#'+zxcstyle[5].split('#')[1].split(' ')[0]; }
 else { zxcrary.push(zxcopts[0]+parseInt(zxcstyle[5].split('px')[0]));  zxcopts[2]='rgb'+(zxcstyle[5].split('rgb')[1].split(')')[0])+')'; }
 }
 var zxcw=parseInt(zxcstyle[1]);
 var zxch=parseInt(zxcstyle[2])||zxcobj.offsetHeight;
 if (!zxcw){ return; }
 zxcS(zxcobj,{position:(zxcstyle[0]=='static'||!zxcstyle[0])?'relative':zxcstyle[0],borderTop:'0px',borderLeft:'0px', borderRight:'0px', borderBottom:'0px'});
 var zxcbwh=zxcrary[0]+(zxcrary[1])?zxcrary[1]:0;
 if (zxcopts[4]){
 var zxcp=zxcS('DIV',{position:zxcobj.style.position,left:zxcobj.style.left,top:zxcobj.style.top,width:(zxcw+zxcbwh*2)+'px',height:(zxch+zxcbwh*2)+'px'});
 zxcobj.parentNode.replaceChild(zxcp,zxcobj);
 zxcp.appendChild(zxcobj);
 zxcS(zxcobj,{left:zxcbwh+'px',top:zxcbwh+'px'});
 }
 for (var zxc0=0;zxc0<zxcrary.length;zxc0++){
 var zxccary=[];
 var zxcclone=zxcS(zxcobj.cloneNode(false),{position:'absolute',overflow:'hidden',zIndex:1+zxc0+'',width:'0px',height:'0px',left:'0px',top:'0px',backgroundColor:(zxc0==0)?zxcstyle[3]:zxcopts[2]},zxcobj);
 zxccary[0]=zxcS('DIV',{position:'absolute',zIndex:1-zxc0+'',width:zxcrary[zxc0]+'px',height:zxcrary[zxc0]+'px',left:zxcw+'px',top:zxch+'px',border:'solid black 0px'},zxcobj);
 for (var zxc1=0;zxc1<zxcrary[zxc0];zxc1++){
  var zxcht=Math.floor(Math.sqrt(Math.pow(zxcrary[zxc0],2)-Math.pow((zxc1+1),2))-1);
  zxcS(zxcclone.cloneNode(false),{left:zxc1+'px',top:'0px',width:'1px',height:(zxcht+1)+'px'},zxccary[0]);
  for(var zxc1a=(zxcht+1);zxc1a<Math.ceil(Math.sqrt(Math.pow(zxcrary[zxc0],2)-Math.pow(zxc1,2)));zxc1a++){
   zxcS(zxcclone.cloneNode(false),{left:zxc1+'px',top:zxc1a+'px',width:'1px',height:zxcAntiAliase(zxc1,zxc1a,zxcrary)+'px'},zxccary[0]);
  }
 }
 var zxcmary=['BR','BL','TL','TR'];
 for (var zxc2=1;zxc2<4;zxc2++){
  zxccary[zxc2]=zxccary[0].cloneNode(true);
  zxcS(zxccary[zxc2],{left:((zxc2<3)?-zxcrary[zxc0]:zxcw)+'px',top:((zxc2<2)?zxch:-zxcrary[zxc0])+'px'},zxcobj);
  var zxcclds=zxccary[zxc2].childNodes;
  if (zxcopts[3].match(zxcmary[zxc2])){
   for (var zxc2a=0;zxc2a<zxcclds.length;zxc2a++){
    var zxctop=parseInt(zxcclds[zxc2a].style.top);
    var zxclft=parseInt(zxcclds[zxc2a].style.left);
    var zxchte=parseInt(zxcclds[zxc2a].style.height);
    zxcS(zxcclds[zxc2a],{left:((zxc2<3)?(zxcrary[zxc0]-zxclft-1):(zxclft))+'px',top:((zxc2<2)?zxctop:(zxcrary[zxc0]-zxchte-zxctop))+'px'});
   }
  }
 }
 for (var zxc3=0;zxc3<zxcmary.length;zxc3++){
  if (!zxcopts[3].match(zxcmary[zxc3])){ zxcS(zxccary[zxc3].firstChild,{left:'0px',top:'0px',width:zxcrary[zxc0]+'px',height:zxcrary[zxc0]+'px'}); }
 }
 var zxcwh=(zxc0<1)?zxcrary[zxc0]:zxcrary[1]-zxcrary[0];
 for (var zxc4=0;zxc4<4;zxc4++){
  zxcS(zxcclone.cloneNode(false),{left:((zxc4<2)?0:(zxc4<3)?-zxcrary[zxc0]:(zxc0<1)?zxcw:zxcw+zxcrary[0])+'px',top:((zxc4<1)?(zxc0<1)?zxch:zxch+zxcrary[0]:(zxc4>1)?0:-zxcrary[zxc0])+'px',width:((zxc4<2)?zxcw:zxcwh)+'px',height:((zxc4<2)?zxcwh:zxch)+'px'},zxcobj);
 }
 }
 if (zxcopts[4]){ zxcOpacity(zxcp,zxcopts[4]); }
}

function zxcOptions(zxcobj){
 var zxcary=zxcobj.className.split('zxc')[1].split(',');
 var zxcopts=[];
 for (var zxc0=0;zxc0<zxcary.length;zxc0++){
 if (zxcary[zxc0].match('Ra')){ zxcopts[0]=parseInt(zxcary[zxc0].replace(/\D/g,'')); }
 else if (zxcary[zxc0].match('Bo')){ zxcopts[1]=parseInt(zxcary[zxc0].split('#')[0].replace(/\D/g,'')); zxcopts[2]='#'+zxcary[zxc0].split('#')[1]; }
 else if (zxcary[zxc0].match('L')||zxcary[zxc0].match('R')){ zxcopts[3]=zxcary[zxc0]; }
 else if (zxcary[zxc0].match('O')){ zxcopts[4]=parseInt(zxcary[zxc0].replace(/\D/g,''));  }
 }
 zxcopts[3]=zxcopts[3]||'BL,BR,TL,TR';
 return zxcopts;
}

function zxcS(zxcele,zxcstyle,zxcp){
 if (typeof(zxcele)=='string'){ zxcele=document.createElement(zxcele); }
 for (key in zxcstyle){ zxcele.style[key]=zxcstyle[key]; }
 if (zxcp){ zxcp.appendChild(zxcele); }
 return zxcele;
}

function zxcStyleAry(zxcel){
 var zxcsary=['position','width','height','backgroundColor','background-Color','borderTop','borderLeft','borderRight','borderBottom'];
 var zxccary=[];
 for (var zxca=0;zxca<zxcsary.length;zxca++){
 zxccary[zxca]=zxcsary[zxca];
 if (zxcel.style[zxcsary[zxca]]){ zxcsary[zxca]=zxcel.style[zxcsary[zxca]]; }
 else if (zxcel.currentStyle){ zxcsary[zxca]=zxcel.currentStyle[zxcsary[zxca]]; }
 else if (document.getComputedStyle){ zxcsary[zxca]=document.defaultView.getComputedStyle(zxcel,null).getPropertyValue(zxcsary[zxca]); }
 }
 for (var zxcb=0;zxcb<zxcsary.length;zxcb++){ if (zxccary[zxcb]==zxcsary[zxcb]){ zxcsary[zxcb]=null; } }
 zxcsary[3]=zxcsary[3]||zxcsary[4];
 return zxcsary;
}

function zxcAntiAliase(zxcx,zxcy,zxcr){
 var zxcxary=[];
 var zxcyary=[];
 var zxcnu=0;
 var zxcside='';
 var zxccross=Math.sqrt((Math.pow(zxcr,2)-Math.pow(zxcx,2)));
 if (zxccross>=zxcy&&zxccross<zxcy+1){
 zxcside='Left';
 zxcxary[zxcnu]=0;
 zxcyary[zxcnu]=zxccross-zxcy;
 zxcnu=zxcnu+1;
 }
 var zxccross=Math.sqrt((Math.pow(zxcr,2)-Math.pow(zxcy+1,2)));
 if (zxccross>=zxcx&&zxccross<zxcx+1){
 zxcside=zxcside+'Top';
 zxcxary[zxcnu]=zxccross-zxcx;
 zxcyary[zxcnu]=1;
 zxcnu=zxcnu+1;
 }
 var zxccross=Math.sqrt((Math.pow(zxcr,2)-Math.pow(zxcx+1,2)));
 if (zxccross>=zxcy&&zxccross<zxcy+1){
 zxcside=zxcside+'Right';
 zxcxary[zxcnu]=1;
 zxcyary[zxcnu]=zxccross-zxcy;
 zxcnu=zxcnu+1;
 }
 var zxccross=Math.sqrt((Math.pow(zxcr,2)-Math.pow(zxcy,2)));
 if (zxccross>=zxcx&&zxccross<zxcx+1){
 zxcside=zxcside+'Bottom';
 zxcxary[zxcnu]=zxccross-zxcx;
 zxcyary[zxcnu]=0;
 }
 return (zxcside=='LeftRight')?Math.min(zxcyary[0],zxcyary[1])+((Math.max(zxcyary[0],zxcyary[1])-Math.min(zxcyary[0],zxcyary[1]))/2):(zxcside=='TopRight')?(1-(((1-zxcxary[0])*(1-zxcyary[1]))/2)):(zxcside=='TopBottom')?Math.min(zxcxary[0],zxcxary[1])+((Math.max(zxcxary[0],zxcxary[1])-Math.min(zxcxary[0],zxcxary[1]))/2):(zxcside=='LeftBottom')?(zxcyary[0]*zxcxary[1])/2:1;
}

function zxcOpacity(zxcobj,zxcopc) {
 if (zxcopc<0||zxcopc>100){ return; }
 if (zxcobj.style.MozOpacity!=null){ zxcobj.style.MozOpacity=(zxcopc/100)-.001; }
 else if (zxcobj.style.opacity!=null){ zxcobj.style.opacity=(zxcopc/100)-.001; }
 else if (zxcobj.style.filter!=null){ zxcobj.style.filter = 'alpha(opacity='+zxcopc+')';        }
 else if (zxcobj.KHTMLOpacity!=null){ zxcobj.KHTMLOpacity=(zxcopc/100)-.001; }
}

// Multiple onload function created by: Simon Willison
// http://simon.incutio.com/archive/2004/05/26/addLoadEvent
function addLoadEvent(func) {
 var oldonload = window.onload;
 if (typeof window.onload != 'function') {
   window.onload = func;
 } else {
   window.onload = function() {
     if (oldonload) {
       oldonload();
     }
     func();
   }
 }
}

addLoadEvent(function() {
 zxcCorners();
});