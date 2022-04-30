function getcookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}

var getIsCookie = function()
{
    var xx = getcookie("session");
    if( xx == 'cookietimeout' )
    {
        document.cookie = '';
        window.location.href='/login/';
    }
}

window.onload=function(){
    setInterval("getIsCookie()",1000); 
}
